[
  'Outdoors & Adventure',
  'Tech',
  'Health & Wellness',
  'Sports & Fitness',
  'Learning',
  'Photography',
  'Food & Drink',
  'Writing',
  'Language & Culture',
  'Music',
  'Film',
  'Sci-Fi & Games',
  'Arts',
  'Book Clubs',
  'Dance',
  'Pets',
  'Hobbies & Crafts',
  'Fashion & Beauty',
  'Social',
  'Career & Business'
].each do |topic|
  Category.find_or_create_by(name: topic)
end
