FactoryBot.define do
  factory :shopping_cart_shipping_method, class: 'ShoppingCart::ShippingMethod' do
    name 'Pick-up In Store'
    days_min 3
    days_max 20
    price 5
  end
end
