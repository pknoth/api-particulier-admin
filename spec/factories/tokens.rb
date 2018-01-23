FactoryGirl.define do
  factory :token do
    sequence(:clear_token) { |n| n }
    sequence(:name) { |n| "name#{n}" }
    email "MyString"

    trait :legacy do
      hashed true
    end

    trait :old do
      hashed false
    end
  end
end
