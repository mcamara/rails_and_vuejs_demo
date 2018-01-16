FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    image_url { Faker::LoremPixel.image("640x480", secure: true) }
    city { create(:city) }
    start_time { Faker::Time.between(Time.zone.now + 1.day, Time.zone.now + 50.days) }
    end_time do |event|
      event.start_time + rand(10..50).minutes
    end
    categories { [create(:category), create(:category)] }
  end
end
