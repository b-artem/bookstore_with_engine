FactoryGirl.define do
  factory :billing_address, class: BillingAddress, parent: :address do
    type 'BillingAddress'
  end
end
