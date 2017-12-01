FactoryBot.define do
  factory :shopping_cart_line_item, class: 'ShoppingCart::LineItem' do
    product { build :product }
    cart { build :shopping_cart_cart }
    price { product.price }
    quantity 1
  end
end
