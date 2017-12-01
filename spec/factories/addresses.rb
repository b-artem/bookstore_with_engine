FactoryGirl.define do
  factory :address do
    type { %w(BillingAddress ShippingAddress).sample }
    first_name { Faker::Name.first_name.tr("' ", '') }
    last_name { Faker::Name.last_name.tr("' ", '') }
    address { Faker::Address.street_address }
    city { Faker::Address.city.tr("-'", '') }
    zip { Faker::Address.zip }
    country { Faker::Address.country_code }
    phone '+380123456789'
  end
end
