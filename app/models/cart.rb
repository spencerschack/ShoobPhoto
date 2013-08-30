class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  before_save :destroy_old_carts
  
  # destroys carts older than a day in order to manage a reasonable amount of them
  
  def destroy_old_carts
    Cart.where('updated_at < ?', Time.now.yesterday).destroy_all
  end

  def shipping
  	line_items.map(&:shipping).max || 0
  end

  def subtotal
    line_items.sum(:price)
  end
  
  def price
    subtotal + shipping
  end
end
