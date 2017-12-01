FactoryGirl.define do
  factory :category do
    name { %w[Mobile development Photo Web design Web development].sample }
  end
end
