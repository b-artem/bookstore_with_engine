FactoryGirl.define do
  factory :shipping_address, class: ShippingAddress, parent: :address do
    type 'ShippingAddress'
  end
end
