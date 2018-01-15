class Event < ApplicationRecord
  validates :name, presence: true

  validates :city, presence: true
  belongs_to :city

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_is_in_future, on: :create
  validate :end_time_after_start_time

  has_many :categories_events, dependent: :destroy
  has_many :categories, through: :categories_events

  self.per_page = 10

  private

  def start_time_is_in_future
    return if start_time > Time.zone.now
    errors.add(:start_time, :start_time_should_be_future)
  end

  def end_time_after_start_time
    return if end_time > start_time
    errors.add(:end_time, :end_time_should_be_after_start_time)
  end
end
