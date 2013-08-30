class CreateFieldsPackageTypes < ActiveRecord::Migration
  def self.up
    create_table :fields_package_types, :id => false do |t|
      t.references :field, :package_type
    end
  end

  def self.down
  end
end
