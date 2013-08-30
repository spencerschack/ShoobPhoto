class Order < ActiveRecord::Base
  
  CardTypes = [
    ['Visa', 'visa'],
    ['MasterCard', 'master'],
    ['Discover', 'discover'],
    ['American Express', 'american_express']
  ]
  
  has_many :line_items
  
  default_scope order('orders.created_at DESC')
  
  attr_accessor :card_number, :card_verification, :clearance
  
  validates_presence_of :first_name, :last_name, :phone, :email, :address, :city, :state, :zip_code, :card_type, :card_expires_on, :price
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :phone, :minimum => 7, :too_short => 'must be at least 7 numbers'
  
  after_validation :validate_purchase, :on => :create
  
  after_create :capture_money
  
  # card_number, expiration, etc... have different names in the ActiveMerchant model than in this Order model
  # this hash contains the translations
  
  NAME_CONVERSIONS = {
    'number' => 'card_number',
    'month' => 'card_expires_on',
    'year' => 'card_expires_on',
    'type' => 'card_type',
    'verification_value' => 'card_verification'
  }.with_indifferent_access
  
  SEARCH_COLUMNS = %w(
    first_name
    last_name
    card_type
    phone
    email
    address
    city
    zip_code
    state
    line_items.data)
  
  def self.search query
    where_statement = SEARCH_COLUMNS.map do |column|
      "#{column} LIKE ?"
    end.join(' OR ')
    Order.joins(:line_items).where(
      [where_statement] + ["%#{query}%"] * SEARCH_COLUMNS.count
    ).all
  end
  
  def phone= value
    super value.gsub(/\D/, '')
  end
  
  private
  
  # returns formatted hash of address information
  
  def purchase_address
    {
      :address1 => address,
      :city => city,
      :state => state,
      :zip => zip_code,
      :country => 'US'
    }
  end
  
  def validate_purchase
    if credit_card.valid?
      @clearance = GATEWAY.authorize(price, credit_card, :address => purchase_address)
      logger.debug "[gateway response] #{@clearance.inspect}"
      unless @clearance.success?
        logger.debug "[response error] #{@clearance.message}"
        errors.add :base, @clearance.message
      end
    else
      credit_card.errors.each do |key, msg|
        key = NAME_CONVERSIONS[key] || key
        logger.debug "[credit_card error] #{key}: #{msg}"
        errors.add key, msg
      end
      false
    end
  end
  
  def capture_money
    logger.debug "[purchase] #{@clearance.inspect}"
    GATEWAY.capture(price, @clearance.authorization)
    line_items.each do |line_item|
      line_item.update_attributes(:cart_id => nil)
    end
  end
  
  # returns credit card object
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
end
