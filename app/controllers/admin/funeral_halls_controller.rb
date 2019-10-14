class Admin::FuneralHallsController < Admin::ApplicationController

    def index
      @funeral_halls = FuneralHall.all
    end

    def new
      @funeral_halls = FuneralHall.new
    end

    def create
      funeral_halls = FuneralHall.new(funeral_halls_params)
      if funeral_halls.save
        redirect_to action: 'index', notice: "新しい会場を登録しました"
      else
        flash.now[:alert] = "登録に失敗しました"
        render :back
      end
    end

    def edit
      @funeral_halls = FuneralHall.find(params[:id])
    end

    def update
      funeral_halls = FuneralHall.find(params[:id])
      if funeral_halls.update(funeral_halls_params)
        redirect_to admin_funeral_halls_path, notice: "修正しました"
      else
        flash.now[:alert] = "修正に失敗しました"
        render :edit
      end
    end

    def destroy
    end

    private

      def funeral_halls_params
        params
          .require(:funeral_hall)
          .permit(:name, :address, :nearest_station)
      end

  end
