class CreateProofs < ActiveRecord::Migration
  def self.up
    create_table :proofs do |t|
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :proofs
  end
end
