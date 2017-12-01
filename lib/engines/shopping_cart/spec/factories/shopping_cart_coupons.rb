FactoryBot.define do
  factory :shopping_cart_coupon, class: 'ShoppingCart::Coupon' do
    code '1234567890'
    discount '20'
    valid_until '2070-09-21'
  end
end
