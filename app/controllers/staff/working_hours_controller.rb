class Staff::WorkingHoursController < Staff::ApplicationController

  def new
  end

  def create
  end

  def edit
    @working_hour = WorkingHour.find(params[:id])

    # 15分未満を切り捨てる
    min = Time.now.min
    if min >= 00 && min < 15
      @t = Time.now.change(min: 00)
      elsif min >= 15 && min < 30
      @t = Time.now.change(min: 15)
      elsif min >= 30 && min < 45
      @t = Time.now.change(min: 30)
      elsif min >=45
      @t = Time.now.change(min: 45)
    end
  end

  def update
    working_hour = WorkingHour.find(params[:id])
    funeral = Funeral.find(working_hour.funeral_id)
    case working_hour_params[:commit]
    when "受ける"
      if working_hour.update(start_time: funeral.start_time, status: "accepted")
        redirect_to staff_home_path
      else
        render :edit
      end
    when "辞退する"
      if working_hour.update(status: "rejected")
        redirect_to staff_home_path
      else

      end
    when nil #終了報告時
      if working_hour.update(end_time: working_hour_params[:end_time])
        redirect_to staff_home_path
      else
        render :edit
      end
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
