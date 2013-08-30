class AddAttachmentFileToCartProduct < ActiveRecord::Migration
  def self.up
    add_column :cart_products, :file_file_name, :string
    add_column :cart_products, :file_content_type, :string
    add_column :cart_products, :file_file_size, :integer
    add_column :cart_products, :file_updated_at, :datetime
  end

  def self.down
    remove_column :cart_products, :file_file_name
    remove_column :cart_products, :file_content_type
    remove_column :cart_products, :file_file_size
    remove_column :cart_products, :file_updated_at
  end
end
