class Shift < ApplicationRecord
belongs_to :user
with_options presence: true do
  validates :scheduled_from
  validates :scheduled_to
end
default_scope -> { order(scheduled_from: :asc) }


  def matches(start_time, quickest_end_time)
    results = Shift.all
    results = results.where("scheduled_from <= ?", start_time)
    results = results.where("scheduled_to >= ?", quickest_end_time )
  end

end
