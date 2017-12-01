FactoryGirl.define do
  factory :payment_form, class: Forms::PaymentForm do
    card_number { rand(1000_0000_0000_0000..9999_9999_9999_9999).to_s }
    name_on_card { Faker::Name.first_name + ' ' + Faker::Name.last_name }
    valid_until { (Date.today + rand(0..120).months).strftime('%m/%y') }
    cvv { rand(100..9999).to_s }
  end
end
