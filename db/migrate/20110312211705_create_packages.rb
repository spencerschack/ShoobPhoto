class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :title
      t.integer :package_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end