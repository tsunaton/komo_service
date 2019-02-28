class Oba::WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)
    if work.save
      redirect_to oba_works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    work = Work.find(params[:id])
    if work.update(work_params)
      redirect_to oba_works_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def work_params
    params.require(:work).permit(:start_time, :end_time, :place_id, :client_id, :number_of_people)
  end

end
