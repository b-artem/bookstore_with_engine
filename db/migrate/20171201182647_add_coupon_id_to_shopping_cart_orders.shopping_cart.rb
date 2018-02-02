# This migration comes from shopping_cart (originally 20171115125636)
class AddCouponIdToShoppingCartOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_cart_orders, :coupon_id, :integer
    add_index :shopping_cart_orders, :coupon_id
  end
end
