class Admin::PayslipsController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @month = Date.today

    case payslip_params[:transition]
    when "next_month"
      @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").next_month
    when "last_month"
      @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").last_month
    end
    @working_hours = WorkingHour.month(@month).where(user_id: @user.id )
    @working_hour = WorkingHour.new
    @working_hour_ids = Array.new
  end

  def payslip_params
    params
      .permit(:month, :transition)
  end
end
