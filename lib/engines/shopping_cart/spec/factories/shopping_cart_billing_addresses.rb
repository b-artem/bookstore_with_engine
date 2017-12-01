FactoryBot.define do
  factory :shopping_cart_billing_address, class: 'ShoppingCart::BillingAddress',
                                 parent: :shopping_cart_address do
    type 'ShoppingCart::BillingAddress'
  end
end
