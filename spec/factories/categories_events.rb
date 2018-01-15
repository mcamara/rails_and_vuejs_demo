FactoryBot.define do
  factory :categories_event do
    category { create(:category) }
    event { create(:event) }
  end
end
