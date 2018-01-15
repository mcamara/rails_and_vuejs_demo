FactoryBot.define do
  factory :city do
    name { [Faker::Zelda.location, Faker::Pokemon.location, Faker::GameOfThrones.city].sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
