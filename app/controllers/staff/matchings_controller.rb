class Staff::machingsController < Staff::Base
  def index
    @machings = maching.all
  end

  def create
  end


end
