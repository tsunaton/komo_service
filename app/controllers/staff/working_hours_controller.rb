class Staff::WorkingHoursController < Staff::ApplicationController

  def new
  end

  def create
  end

  def edit
    @working_hour = WorkingHour.find(params[:id])
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
        render :edit
      end
    end
  end

  def destroy
  end

  private

  def working_hour_params
    params.permit(:commit)
  end

end
