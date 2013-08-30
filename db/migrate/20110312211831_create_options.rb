class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :title
      t.integer :option_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
