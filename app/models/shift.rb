class Shift < ApplicationRecord
  has_many :machings
  has_many :works, through: :machings

  def matches(start_time, end_time)
    results = Shift.all
    results = results.where("start_time <= ?", start_time)
    results = results.where("end_time >= ?", end_time)

  end

end
