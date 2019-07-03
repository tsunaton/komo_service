module ApplicationHelper
  def work_started?(working_hour)
    if working_hour.status == "accepted" && start_time = working_hour.start_time
      Time.now >= start_time
    end
  end

  def piyo(checked_times, s, f, i, i_2)

     if checked_times.any?{|ct| ct.scheduled_from <= s && ct.scheduled_to > s}
      return f.check_box "scheduled_from#{i}-#{i_2}", {checked: true}, s, nil
     else
      return f.check_box "scheduled_from#{i}-#{i_2}", {}, s, nil
     end

  end

end
