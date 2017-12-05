# This migration comes from shopping_cart (originally 20171115094142)
class CreateShoppingCartLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_line_items do |t|
      t.integer :product_id, foreign_key: true
      t.integer :cart_id, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 7, scale: 2
      t.timestamps
    end
  end
end
