class FuneralHall < ApplicationRecord
belongs_to :funeral
has_many :available_halls
has_many :users, through: :available_halls

validates :name, presence: true, length: { maximum: 50 },uniqueness: true
with_options length: { maximum: 50 } do
  validates :address
  validates :nearest_station
end
end
