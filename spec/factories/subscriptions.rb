FactoryBot.define do
  factory :subscription do
    game

    trait :with_present_user do
      user
    end

    trait :without_present_user do
      user_name { "John" }
      user_email { "john@mail.com" }
    end
  end
end
