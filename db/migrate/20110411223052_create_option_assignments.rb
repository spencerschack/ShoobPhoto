class CreateOptionAssignments < ActiveRecord::Migration
  def self.up
    create_table :option_assignments do |t|
      t.integer :option_type_id
      t.integer :package_id
      t.integer :school_id
      t.datetime :begin
      t.datetime :end

      t.timestamps
    end
  end

  def self.down
    drop_table :option_assignments
  end
end
