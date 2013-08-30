class CreateOptionTypesPackages < ActiveRecord::Migration
  def self.up
    create_table :option_types_packages do |t|
      t.references :option_type, :package, :school
      t.datetime :begin, :end
    end
  end

  def self.down
    drop_table :option_types_packages
  end
end
