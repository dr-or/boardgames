FactoryBot.define do
  factory :photo do
    game
    user

    after(:build) do |photo|
      photo.photo.attach(io: File.open('spec/fixtures/anonymous.jpg'), filename: 'anonymous.jpg')
    end
  end
end
