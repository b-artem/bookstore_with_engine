# This migration comes from shopping_cart (originally 20171115125726)
class AddCouponIdToShoppingCartCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_cart_carts, :coupon_id, :integer
    add_index :shopping_cart_carts, :coupon_id
  end
end
