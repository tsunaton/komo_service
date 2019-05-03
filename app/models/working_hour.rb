class WorkingHour < ApplicationRecord
belongs_to :user
belongs_to :funeral

enum status: [
  :sent_email,
  :accepted,
  :rejected
]
end
