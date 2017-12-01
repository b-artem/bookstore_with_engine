class CreateShippingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_methods do |t|
      t.string :name
      t.integer :days_min
      t.integer :days_max
      t.float :price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
