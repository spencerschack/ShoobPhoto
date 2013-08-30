class AddPurchaseIdToCartPackage < ActiveRecord::Migration
  def self.up
    add_column :cart_packages, :purchase_id, :string
  end

  def self.down
    remove_column :cart_packages, :purchase_id
  end
end
