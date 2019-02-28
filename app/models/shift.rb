class Shift < ApplicationRecord
  # ATTRIBUTES = %i(
  #   start_time
  #   end_time
  #     )

  # attr_accessor(*ATTRIBUTES)

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def matches
    results = Shift.all
    binding.pry
    results = results.where("start_time >= ?", @start_time)#より後
    results = results.where("end_time <= ?", @end_time)#より前

    return results

  end

end
