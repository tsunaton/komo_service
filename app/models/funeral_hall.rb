class FuneralHall < ApplicationRecord
belongs_to :funeral, optional: true
has_many :available_halls
has_many :users, through: :available_halls

validates :name, presence: true, length: { maximum: 50 },uniqueness: true
validates :address, length: { maximum: 50 }
validates :nearest_station, length: { maximum: 50 }
end
