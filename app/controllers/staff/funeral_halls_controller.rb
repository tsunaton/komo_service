class Staff::FuneralHallsController < Staff::ApplicationController

    def index
      @funeral_halls = FuneralHall.all
    end

  end
