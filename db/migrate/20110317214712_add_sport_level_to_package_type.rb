class AddSportLevelToPackageType < ActiveRecord::Migration
  def self.up
    add_column :package_types, :sport_level, :boolean
  end

  def self.down
    remove_column :package_types, :sport_level
  end
end
