class CreateFieldsPackages < ActiveRecord::Migration
  def self.up
    create_table :fields_packages, :id => false do |t|
      t.references :field, :package
    end
  end

  def self.down
    drop_table :fields_packages
  end
end
