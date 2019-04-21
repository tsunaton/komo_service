class Admin::MachingsController < Admin::ApplicationController
  def index
    @machings = Maching.all

    @machings.each do |maching|
      @funerals = Funeral.where(id: maching.funeral_id)
      @users = User.where(id: maching.user_id)
    end

    @funerals.each do |funeral|
      @funeral_hallss = FuneralHall.where(id: funeral.funeral_halls_id)
      @clients = Client.where(id: funeral.client_id)
    end

  end

  def new
  end

  def create
    maching = Maching.new(params[:user_id], params[:funeral_id])
    if maching.save
      redirect_to admin_maching_path
    else
      render new_admin_matching_path
    end
  end

end
