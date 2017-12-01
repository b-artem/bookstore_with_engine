# This migration comes from shopping_cart (originally 20171115125517)
class CreateShoppingCartCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_coupons do |t|
      t.string :code
      t.decimal :discount, precision: 4, scale: 1
      t.date :valid_until
      t.timestamps
    end
  end
end
