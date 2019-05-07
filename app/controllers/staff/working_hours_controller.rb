class Staff::WorkingHoursController < Staff::ApplicationController

  def new
  end

  def create
  end

  def edit
    @working_hour = WorkingHour.find(params[:id])

    # 15分未満を切り捨てる
    @t = Time.at((Time.now.to_f / 15.minutes).round * 15.minutes)
  end

  def update
    working_hour = WorkingHour.find(params[:id])
    action_after = proc {|cond|
      if cond
        redirect_to staff_home_path
      else
        render :edit
      end
    }
    case working_hour_params[:commit]
    when "受ける"
      action_after.(working_hour.update(start_time: working_hour.funeral.start_time, status: "accepted"))
    when "辞退する"
      action_after.(working_hour.update(status: "rejected"))
    else
      action_after.(working_hour.update(end_time: working_hour_params[:end_time]))
    end
  end

  def destroy
  end

  private

  def working_hour_params

    if params[:working_hour]
      params
        .require(:working_hour)
        .permit(:end_time)
    else
      params.permit(:commit)
    end
  end


end
