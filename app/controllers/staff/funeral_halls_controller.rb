class Staff::Funeral_hallsController < Staff::ApplicationController
before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

    def index
      @funeral_hallss = Funeral_hall.all
    end

    def new
      @funeral_halls = Funeral_hall.new
    end

    def create
      funeral_halls = Funeral_hall.new(funeral_halls_params)
      if funeral_halls.save
        redirect_to action: 'index'
      else
        render :back
      end
    end

    def edit
      @funeral_halls = Funeral_hall.find(params[:id])
    end

    def update
      funeral_halls = Funeral_hall.find(params[:id])
      if funeral_halls.update(funeral_halls_params)
        redirect_to staff_funeral_hallss_path
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
