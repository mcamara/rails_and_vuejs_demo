FactoryBot.define do
  factory :city do
    name { String.random(20) }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
