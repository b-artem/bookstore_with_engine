FactoryGirl.define do
  factory :review do
    sequence :title { |n| "Review no. #{n}" }
    text { Faker::Lorem.paragraph }
    book { build :book }
    user { create :user }
  end
end
