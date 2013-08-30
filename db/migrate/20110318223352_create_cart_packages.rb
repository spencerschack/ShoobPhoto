class CreateCartPackages < ActiveRecord::Migration
  def self.up
    create_table :cart_packages do |t|
      t.integer :cart_id
      t.integer :school_id
      t.integer :package_id
      t.string :student_first_name
      t.string :student_last_name
      t.string :student_grade
      t.string :student_teacher
      t.string :student_sport_level
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_packages
  end
end
