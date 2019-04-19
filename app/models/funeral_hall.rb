class FuneralHall < ApplicationRecord
belongs_to :funeral
has_many :available_halls
has_many :users, through: :available_halls
end
