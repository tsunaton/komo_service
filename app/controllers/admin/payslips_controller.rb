class Admin::PayslipsController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @working_hours = WorkingHour.where(user_id: params[:id]).where(status: "done")
  end
end
