class AddTeacherToSchool < ActiveRecord::Migration
  def self.up
    add_column :schools, :teacher, :boolean
  end

  def self.down
    remove_column :schools, :teacher
  end
end
