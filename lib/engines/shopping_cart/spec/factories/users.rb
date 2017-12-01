FactoryBot.define do
  factory :user, class: ShoppingCart.user_class.to_s do
    email { Faker::Internet.email }
    password 'Aa12345678'
  end
end
