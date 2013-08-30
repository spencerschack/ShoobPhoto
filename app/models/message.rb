class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :name, :email, :phone, :message, :school, :interests
  
  validates_presence_of :name, :email, :school, :message
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def initialize(attrs = {})
    attrs.each do |key,value|
      send("#{key}=", value)
    end
  end
  
  def persisted?
    false
  end
end