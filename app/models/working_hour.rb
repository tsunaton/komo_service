class WorkingHour < ApplicationRecord
  belongs_to :user
  belongs_to :funeral
  default_scope -> { order(start_time: :asc) }

  enum status: [
    :waiting,
    :accepted,
    :rejected,
    :done
  ]
end
