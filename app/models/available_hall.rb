class AvailableHall < ApplicationRecord
belongs_to :user
belongs_to :funeral_hall

with_options presence: true do
  validates :user_id
  validates :funeral_hall_id
end
end
