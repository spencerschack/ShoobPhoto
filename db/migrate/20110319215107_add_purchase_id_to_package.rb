class AddPurchaseIdToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :purchase_id, :boolean
  end

  def self.down
    remove_column :packages, :purchase_id
  end
end
