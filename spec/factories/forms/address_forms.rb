FactoryGirl.define do
  factory :address_form, class: Forms::AddressForm do
    type { %w(BillingAddress ShippingAddress).sample }
    first_name { Faker::Name.first_name.tr("' ", '') }
    last_name { Faker::Name.last_name.tr("' ", '') }
    address { Faker::Address.street_address.tr("'", '') }
    city { Faker::Address.city.tr("-'", '') }
    zip { Faker::Address.zip }
    country { Faker::Address.country_code }
    phone '+380123456789'
    order_id { create(:order).id }
  end
end
