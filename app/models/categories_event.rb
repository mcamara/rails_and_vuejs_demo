class CategoriesEvent < ApplicationRecord
  belongs_to :category
  belongs_to :event

  validates :event, uniqueness: { scope: :category }
end
