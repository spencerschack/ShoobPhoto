class Option < ActiveRecord::Base
  belongs_to :option_type
  has_many :prices
  
  validates_presence_of :title
  
  has_attached_file :image, :url => '/options/:id/:style/:filename', :path => ':rails_root/public:url', :styles => {:thumb => '50x100'}
  
  accepts_nested_attributes_for :prices, :reject_if => proc {|attrs| attrs['price'].blank?}, :allow_destroy => true
  
  def price school
    output = prices.where('school_id = ? OR school_id IS NULL', school).where('end > ? OR end IS NULL', Time.now).where('begin < ? OR begin IS NULL', Time.now).order('school_id DESC, end DESC, begin DESC').limit(1)
    output.any? ? output.first.price : 0
  end
end
