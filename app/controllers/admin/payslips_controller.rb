class Admin::PayslipsController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @working_hours = WorkingHour.where(user_id: params[:id]).where(status: "done")
  end
end
