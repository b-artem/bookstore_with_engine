class AddOrderIdToShoppingCartLineItem < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_cart_line_items, :order_id, :integer
    add_index :shopping_cart_line_items, :order_id
  end
end
