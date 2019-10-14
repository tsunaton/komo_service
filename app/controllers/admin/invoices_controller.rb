class Admin::InvoicesController < Admin::ApplicationController

  def index
    @clients = Client.all
  end

  def show
    @month = Date.today
    @client = Client.find(params[:id])

    case invoice_params[:transition]
    when "next_month"
      @month = Time.zone.parse(invoice_params[:month] + " 00:00:00").next_month
    when "last_month"
      @month = Time.zone.parse(invoice_params[:month] + " 00:00:00").last_month
    end
    @working_hours = WorkingHour.month(@month).where(funeral_id: @client.funerals.ids)
    @working_hour = WorkingHour.new
    @working_hour_ids = Array.new
  end

  private
    def invoice_params
      params
        .permit(:month, :transition)
    end
end
