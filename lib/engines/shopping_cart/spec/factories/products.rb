FactoryBot.define do
  factory :product, class: ShoppingCart.product_class.to_s do
    sequence(:title) { |n| "Title #{n}" }
    price { rand(10.0..150.0) }
  end
end
