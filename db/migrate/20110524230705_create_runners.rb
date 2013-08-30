class CreateRunners < ActiveRecord::Migration
  def self.up
    create_table :runners do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :email
      t.integer :age
      t.string :gender
      t.string :shirt_size
      t.date :birthday

      t.timestamps
    end
  end

  def self.down
    drop_table :runners
  end
end
