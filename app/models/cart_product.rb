class CartProduct < ActiveRecord::Base
  attr_accessor :file
  
  belongs_to :product
    
  validates_presence_of :product_id, :school, :quantity, :file
  validates_numericality_of :quantity
  validate :minimum_quantity
  
  # serialize file to store data about the uploaded file until moved to line_item
  
  serialize :file
  
  # validates the minimum quantity
  
  def minimum_quantity
    errors.add :quantity, "cannot be less than the minimum quantity of #{product.minimum_quantity}" if quantity? && !product.nil? && quantity < product.minimum_quantity
  end
  
  # provides a similar method to the one found in cart_package.rb that provides the line_item data
  
  def data
    {
      :product => product.title,
      :school => school,
      :quantity => quantity
    }
  end
  
  def price
    quantity*product.price
  end
end
