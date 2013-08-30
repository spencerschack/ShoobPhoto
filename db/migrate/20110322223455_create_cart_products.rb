class CreateCartProducts < ActiveRecord::Migration
  def self.up
    create_table :cart_products do |t|
      t.integer :cart_id
      t.integer :order_id
      t.integer :product_id
      t.string :school

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_products
  end
end
