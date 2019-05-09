class WorkingHour < ApplicationRecord
belongs_to :user
belongs_to :funeral

enum status: [
  :waiting,
  :accepted,
  :rejected,
  :done
]
end
