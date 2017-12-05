# This migration comes from shopping_cart (originally 20171115124611)
class CreateShoppingCartOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_orders do |t|
      t.string :number
      t.datetime :completed_at
      t.string :state
      t.references :user, foreign_key: true
      t.integer :shipping_method_id
      t.boolean :use_billing_address_as_shipping, default: false
      t.timestamps
    end
    add_index :shopping_cart_orders, :number
    add_index :shopping_cart_orders, :shipping_method_id
  end
end
