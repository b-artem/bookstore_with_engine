FactoryGirl.define do
  factory :coupon do
    code "1234567890"
    discount "20"
    valid_until "2025-09-21"
  end
end
