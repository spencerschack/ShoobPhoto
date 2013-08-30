class AddEmailPictureToCartPackage < ActiveRecord::Migration
  def self.up
    add_column :cart_packages, :email_picture, :boolean
  end

  def self.down
    remove_column :cart_packages, :email_picture
  end
end
