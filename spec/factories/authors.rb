FactoryGirl.define do
  factory :author do
    first_name { Faker::Name.first_name.tr("' ", '') }
    last_name { Faker::Name.last_name.tr("' ", '') }
  end

  factory :author_with_description, parent: :author do
    description do
      "Here comes a description of wonderful life of #{first_name} #{last_name}"
    end
  end
end
