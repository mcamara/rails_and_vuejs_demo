categories = Category.all
cities = City.all
lorempixel_categories = %w(abstract animals business cats city food nightlife fashion people nature sports technics transport)

1000.times do
  FactoryBot.create(
    :event,
    categories: categories.sample(2),
    city: cities.sample,
    image_url: Faker::LoremPixel.image("640x480", false, lorempixel_categories.sample)
  )
end
