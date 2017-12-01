FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '12345678'
    confirmed_at { Time.now }

    factory :admin do
      role 'admin'
    end
  end
end
