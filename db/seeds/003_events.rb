categories = Category.all
cities = City.all

1000.times do
  FactoryBot.create(
    :event,
    categories: categories.sample(2),
    city: cities.sample
  )
end
