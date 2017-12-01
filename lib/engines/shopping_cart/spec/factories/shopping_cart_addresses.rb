FactoryBot.define do
  factory :shopping_cart_address, class: 'ShoppingCart::Address' do
    type { %w(ShoppingCart::BillingAddress ShoppingCart::ShippingAddress).sample }
    first_name { Faker::Name.first_name.tr("' ", '') }
    last_name { Faker::Name.last_name.tr("' ", '') }
    address { Faker::Address.street_address.tr("'", '') }
    city { Faker::Address.city.tr("-'", '') }
    zip { Faker::Address.zip }
    country { Faker::Address.country_code }
    phone '+380123456789'
  end
end
