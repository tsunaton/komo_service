class Admin::PayslipsController < Admin::ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @users = User.all
  end

  def show
    @working_hours = WorkingHour.where(user_id: params[:id]).where(status: "done")
  end
end
