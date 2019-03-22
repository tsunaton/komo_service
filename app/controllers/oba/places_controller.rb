class Oba::PlacesController < ApplicationController
before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

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
      @place = Place.find(params[:id])
    end

    def update
      place = Place.find(params[:id])
      if place.update(place_params)
        redirect_to oba_places_path
      else
        render :edit
      end
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
