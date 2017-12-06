class CreateShoppingCartShippingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_shipping_methods do |t|
      t.string :name
      t.integer :days_min
      t.integer :days_max
      t.decimal :price, precision: 7, scale: 2
      t.timestamps
    end
  end
end
