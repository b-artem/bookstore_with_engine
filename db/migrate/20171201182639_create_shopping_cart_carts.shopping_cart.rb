# This migration comes from shopping_cart (originally 20171114142023)
class CreateShoppingCartCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_carts do |t|
      t.timestamps
    end
  end
end
