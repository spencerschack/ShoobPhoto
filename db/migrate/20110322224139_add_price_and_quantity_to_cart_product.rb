class AddPriceAndQuantityToCartProduct < ActiveRecord::Migration
  def self.up
    add_column :cart_products, :price, :integer
    add_column :cart_products, :quantity, :integer
  end

  def self.down
    remove_column :cart_products, :quantity
    remove_column :cart_products, :price
  end
end
