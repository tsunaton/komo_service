class PlacesController < ApplicationController

    def index
      @places = Place.all
    end

    def new
      @place = Place.new
    end

    def create
      place = Place.new(place_params)
      if place.save
        redirect_to action: 'index'
      else
        render :back
      end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

      def place_params
        params
          .require(:place)
          .permit(:name, :address, :nearest_station)
      end

  end
