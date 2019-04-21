class Staff::MachingsController < Staff::ApplicationController
  def index
    @machings = maching.all
  end

  def create
  end


end
