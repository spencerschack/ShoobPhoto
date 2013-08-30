class AddEmailPictureToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :email_picture, :boolean
  end

  def self.down
    remove_column :packages, :email_picture
  end
end
