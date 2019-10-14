class WorkingHour < ApplicationRecord
  belongs_to :user
  belongs_to :funeral
  default_scope -> { order(start_time: :asc) }
  # scope :month, -> month { where(status: "done").where(start_time: month.beginning_of_month..month.end_of_month) }
  scope :month, -> month { where(start_time: month.beginning_of_month..month.end_of_month) }

  enum status: [
    :waiting,
    :accepted,
    :rejected,
    :done
  ]

  WORKINGHOUR_ATTRIBUTES = %i(
   id end_time(1i) end_time(2i) end_time(3i) end_time(4i) end_time(5i)
   start_time(1i) start_time(2i) start_time(3i) start_time(4i) start_time(5i)
  )
end
