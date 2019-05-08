class Admin::InvoicesController < Admin::ApplicationController
  # before_action :logged_in_user

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    funerals = Funeral.where(client_id: params[:id])
    funerals.each { |f| @working_hours = Array(nil) << f.working_hours[0]}
  end
end
