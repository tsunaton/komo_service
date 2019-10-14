class Staff::PayslipsController < Staff::ApplicationController

  def show
    @month = Date.today

    case payslip_params[:transition]
      when "next_month"
        @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").next_month
      when "last_month"
        @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").last_month
    end

    @working_hours = WorkingHour.month(@month).where(user_id: @current_user.id ).where(status: "done")
  end

  def payslip_params
    params
      .permit(:month, :transition)
  end
end
