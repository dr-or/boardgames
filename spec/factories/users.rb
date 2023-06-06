FactoryBot.define do
  factory :user do
    name { "John_#{rand(999)}" }
    sequence(:email) { |n| "john-doe#{n}@email.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456" }
  end
end
