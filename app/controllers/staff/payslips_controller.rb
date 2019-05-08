class Staff::PayslipsController < Staff::ApplicationController
  def show
    @working_hours = WorkingHour.where(user_id: @current_user.id)
  end
end
