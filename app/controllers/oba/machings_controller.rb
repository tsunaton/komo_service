class Oba::MachingsController < ApplicationController
  def index
    @machings = Maching.all

    @machings.each do |maching|
      @works = Work.where(id: maching.work_id)
      @users = User.where(id: maching.user_id)
    end

    @works.each do |work|
      @places = Place.where(id: work.place_id)
      @clients = Client.where(id: work.client_id)
    end
    
  end

  def new
  end

  def create
    maching = Maching.new(params[:user_id], params[:work_id])
    if maching.save
      redirect_to oba_maching_path
    else
      render new_oba_matching_path
    end
  end

end
