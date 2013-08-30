class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.integer :price
      t.integer :school_id
      t.datetime :begin
      t.datetime :end

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
