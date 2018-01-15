FactoryBot.define do
  factory :category do
    name { Faker::Lorem.words(4).join(' ') }
  end
end
