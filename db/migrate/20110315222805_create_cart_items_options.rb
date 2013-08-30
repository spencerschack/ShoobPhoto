class CreateCartItemsOptions < ActiveRecord::Migration
  def self.up
    create_table :cart_items_options, :id => false do |t|
      t.references :cart_item, :option
    end
  end

  def self.down
    drop_table :cart_items_options
  end
end
