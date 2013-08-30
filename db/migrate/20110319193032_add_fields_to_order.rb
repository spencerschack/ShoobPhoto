class AddFieldsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :card_type, :string
    add_column :orders, :card_expires_on, :date
    add_column :orders, :phone, :integer
    add_column :orders, :email, :string
    add_column :orders, :address, :string
    add_column :orders, :address_two, :string
    add_column :orders, :city, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :state, :string
    add_column :orders, :price, :integer
  end

  def self.down
    remove_column :orders, :price
    remove_column :orders, :state
    remove_column :orders, :zip_code
    remove_column :orders, :city
    remove_column :orders, :address_two
    remove_column :orders, :address
    remove_column :orders, :email
    remove_column :orders, :phone
    remove_column :orders, :card_expires_on
    remove_column :orders, :card_type
    remove_column :orders, :last_name
    remove_column :orders, :first_name
  end
end
