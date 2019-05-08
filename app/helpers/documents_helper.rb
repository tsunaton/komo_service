module DocumentsHelper
  def calculate_working_hour(work)
    working_hours = (work.end_time - work.start_time) / 3600
    working_hours.ceil
  end

  def calculate_pay_per_day(work)
    pay_per_day = @current_user.pay_per_hour * calculate_working_hour(work)
    pay_per_day.ceil
  end

  def calculate_monthly(works)
    works.inject(0){ |sum, w| sum += calculate_pay_per_day(w) }
  end
end
