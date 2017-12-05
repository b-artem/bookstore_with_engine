# This migration comes from shopping_cart (originally 20171115125118)
class AddOrderIdToShoppingCartAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_cart_addresses, :order_id, :integer
    add_index :shopping_cart_addresses, :order_id
  end
end
