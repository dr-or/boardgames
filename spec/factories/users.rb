FactoryBot.define do
  factory :user do
    name { "John_#{rand(999)}" }
    sequence(:email) { |n| "john-doe#{n}@email.com" }

    after(:build) do |user|
      user.password_confirmation = user.password = "123456"
      user.avatar.attach(io: File.open('spec/fixtures/anonymous.jpg'), filename: 'anonymous.jpg')
    end
  end
end
