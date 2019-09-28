module DocumentsHelper
  def calculate_working_hour(work)
    if work.end_time
      working_hours = (work.end_time - work.start_time) / 3600
      working_hours.round(2)
    else
      return 0
    end
  end

  def calculate_pay_per_day(work, per_hour)
    if calculate_working_hour(work) < 4
      pay_per_day = per_hour * 4
    else
      pay_per_day = per_hour * calculate_working_hour(work)
    end
    pay_per_day.ceil
  end

  def calculate_monthly(works, per_hour)
    works.inject(0){ |sum, w| sum += calculate_pay_per_day(w, per_hour) }
  end
end
