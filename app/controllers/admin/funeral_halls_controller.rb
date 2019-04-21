class Admin::FuneralHallsController < Admin::ApplicationController
before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

    def index
      @funeral_halls = FuneralHall.all
    end

    def new
      @funeral_halls = FuneralHall.new
    end

    def create
      funeral_halls = FuneralHall.new(funeral_halls_params)
      if funeral_halls.save
        redirect_to action: 'index'
      else
        render :back
      end
    end

    def edit
      @funeral_halls = FuneralHall.find(params[:id])
    end

    def update
      funeral_halls = FuneralHall.find(params[:id])
      if funeral_halls.update(funeral_halls_params)
        redirect_to admin_funeral_halls_path
      else
        render :edit
      end
    end

    def destroy
    end

    private

      def funeral_halls_params
        params
          .require(:funeral_halls)
          .permit(:name, :address, :nearest_station)
      end

  end
