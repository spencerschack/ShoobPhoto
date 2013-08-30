class CreateCartPackagesOptions < ActiveRecord::Migration
  def self.up
    create_table :cart_packages_options, :id => false do |t|
      t.references :cart_package, :option
    end
  end

  def self.down
    drop_table :cart_packages_options
  end
end
