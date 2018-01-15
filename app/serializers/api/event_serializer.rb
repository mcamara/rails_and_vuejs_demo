class Api::EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :end_time
  belongs_to :city, serializer: Api::CitySerializer
  has_many :categories, each_serializer: Api::CategorySerializer
end
