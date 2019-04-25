class Shift < ApplicationRecord
belongs_to :user

with_options presence: true do
  validates :scheduled_from
  validates :scheduled_to
end

  def matches(start_time, end_time)
    results = Shift.all
    results = results.where("start_time <= ?", start_time)
    results = results.where("end_time >= ?", end_time)

  end

end
