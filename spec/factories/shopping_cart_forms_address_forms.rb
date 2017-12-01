FactoryBot.define do
  factory :shopping_cart_forms_address_form, class: ShoppingCart::Forms::AddressForm do
    type { %w(ShoppingCart::BillingAddress ShoppingCart::ShippingAddress).sample }
    first_name { Faker::Name.first_name.tr("' ", '') }
    last_name { Faker::Name.last_name.tr("' ", '') }
    address { Faker::Address.street_address.tr("'", '') }
    city { Faker::Address.city.tr("-'", '') }
    zip { Faker::Address.zip }
    country { Faker::Address.country_code }
    phone '+380123456789'
    order_id { build_stubbed(:shopping_cart_order).id }
  end
end
