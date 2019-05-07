class Admin::InvoicesController < Admin::ApplicationController
  # before_action :logged_in_user

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    @working_hours = WorkingHour.where(params[:id])
  end
end
