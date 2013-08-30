class CreateProofImages < ActiveRecord::Migration
  def self.up
    create_table :proof_images do |t|
      t.integer :proof_id

      t.timestamps
    end
  end

  def self.down
    drop_table :proof_images
  end
end
