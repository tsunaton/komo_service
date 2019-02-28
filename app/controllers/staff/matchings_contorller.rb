class Staff::machingsController < ApplicationController
  def index
    @machings = maching.all
  end

  def create
  end


end
