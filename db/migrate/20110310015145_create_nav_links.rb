class CreateNavLinks < ActiveRecord::Migration
  def self.up
    create_table :nav_links do |t|
      t.string :title
      t.string :path
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :nav_links
  end
end
