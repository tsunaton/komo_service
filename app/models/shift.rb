class Shift < ApplicationRecord
  belongs_to :user

  def matches(start_time, end_time)
    results = Shift.all
    results = results.where("start_time <= ?", start_time)
    results = results.where("end_time >= ?", end_time)

  end

end
