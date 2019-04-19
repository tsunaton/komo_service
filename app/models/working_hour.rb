class WorkingHour < ApplicationRecord
belongs_to :user

with_options presence: true do
  validates :user_id
  validates :start_time
end
end
