class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :runner_id
      t.integer :race_id
      t.string :distance
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
