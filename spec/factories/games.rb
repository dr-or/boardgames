FactoryBot.define do
  factory :game do
    title { "Game" }
    address { "Game-city, Game str, 1" }
    datetime { 1.hour.ago }

    user
  end
end
