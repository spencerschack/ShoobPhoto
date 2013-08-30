class CreateTablePackagesSchools < ActiveRecord::Migration
  def self.up
  	create_table :packages_schools, :id => false do |t|
  		t.references :package, :school
  	end
  end

  def self.down
  	drop_table :packages_schools
  end
end
