FactoryBot.define do
  factory :shopping_cart_shipping_address, class: 'ShoppingCart::ShippingAddress',
                                  parent: :shopping_cart_address do
    type 'ShoppingCart::ShippingAddress'
  end
end
