module DocumentsHelper
  def calculate_working_hour(work)
    if work.status == "done"
      working_hours = (work.end_time - work.start_time) / 3600
      working_hours.ceil
    end
  end

  def calculate_pay_per_day(work, per_hour)
    pay_per_day = per_hour * calculate_working_hour(work)
    pay_per_day.ceil
  end

  def calculate_monthly(works, per_hour)
    works.inject(0){ |sum, w| sum += calculate_pay_per_day(w, per_hour) }
  end

  def calculate_pay_per_this_month_for_client(client)
    funerals = Funeral.where(client_id: client.id)

    funerals.each { |f| @working_hours = Array(nil) << WorkingHour.find(f.id)}
    @working_hours
    
    @sum = 0
    @working_hours.each { |w| @sum += calculate_pay_per_day(w) }
    @sum
  end
end
