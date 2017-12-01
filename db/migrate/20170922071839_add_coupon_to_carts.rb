class AddCouponToCarts < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :coupon, foreign_key: true
  end
end
