FactoryGirl.define do
  factory :order do
    user { build :user }
  end
end
