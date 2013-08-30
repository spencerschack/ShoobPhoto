class Mailer
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :addresses, :subject, :message
  
  def initialize(attrs = {})
    attrs.each do |key,value|
      send("#{key}=", value)
    end
  end
  
  def persisted?
    false
  end
end