class CreatePackageTypesSchools < ActiveRecord::Migration
  def self.up
    create_table :package_types_schools, :id => false do |t|
      t.references :package_type
      t.references :school
    end
  end

  def self.down
    drop_table :package_types_schools
  end
end
