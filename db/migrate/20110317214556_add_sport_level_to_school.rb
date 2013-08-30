class AddSportLevelToSchool < ActiveRecord::Migration
  def self.up
    add_column :schools, :sport_level, :boolean
  end

  def self.down
    remove_column :schools, :sport_level
  end
end
