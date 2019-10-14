module DocumentsHelper

  def get_works_in_month(datetime)
    WorkingHour.month(datetime)
  end

  def calculate_working_hour(work)
    if work.end_time
      working_hours = (work.end_time - work.start_time) / 3600
      working_hours.round(2)
    else
      return 0
    end
  end

  #利益の計算
  def calculate_sales(works)
    works.inject(0){ |monthly_gains, work|
      pay_per_hour = work.funeral.client.dispatching_fee_per_hour
      if calculate_working_hour(work) < 4
        pay_per_day = pay_per_hour * 4
      else
        pay_per_day = pay_per_hour * calculate_working_hour(work)
      end
      monthly_gains += pay_per_day.ceil }
  end

  #コストの計算
  def calculate_labor_costs(works)
    works.inject(0){ |monthly_labor_costs, work|
      pay_per_hour = work.user.pay_per_hour
      if calculate_working_hour(work) < 4
        pay_per_day = pay_per_hour * 4
      else
        pay_per_day = pay_per_hour * calculate_working_hour(work)
      end
      unless work.transportation_fee.nil?
        pay_per_day + work.transportation_fee
      end
      monthly_labor_costs += pay_per_day.ceil }
  end

  def calculate_pay_per_day_without_transportation_fee(work, pay_per_hour)
    calculate_working_hour(work)*pay_per_hour
  end

  def calculate_pay_per_day(work, pay_per_hour)
    calculate_working_hour(work)*pay_per_hour + work.transportation_fee
  end

  #汎用サム計算機
  def calculate_pay_per_month(works, pay_per_hour)
    works.inject(0){ |sum, work|
      if calculate_working_hour(work) < 4
        pay_per_day = pay_per_hour * 4
      else
        pay_per_day = pay_per_hour * calculate_working_hour(work)
      end
      sum += pay_per_day.ceil }
  end

  def transportation_fee_total(works)
    works.pluck(:transportation_fee).sum
  end

end
