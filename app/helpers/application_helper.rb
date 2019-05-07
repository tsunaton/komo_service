module ApplicationHelper
  def work_started?(working_hour)
    if working_hour.status == "accepted" && start_time = working_hour.start_time
      Time.now >= start_time
    end
  end
end
