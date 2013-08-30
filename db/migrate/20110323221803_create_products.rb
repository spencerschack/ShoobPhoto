class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.string :slug
      t.integer :price
      t.integer :minimum_quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
