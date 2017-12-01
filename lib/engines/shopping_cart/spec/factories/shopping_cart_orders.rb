FactoryBot.define do
  factory :shopping_cart_order, class: 'ShoppingCart::Order' do
    user { build :user }
  end
end
