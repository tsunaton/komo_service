class Admin::InvoicesController < Admin::ApplicationController

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    @working_hours = WorkingHour.where(funeral_id: @client.funerals.ids).where(status: "done")
  end
end
