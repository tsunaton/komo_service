class Oba::WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def new
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

  def temp
    @users = params[:user_id]
    render :new
  end

  def destroy
  end

  def searching

    start_time = Time.zone.local(params["start_time(1i)"].to_i, params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(4i)"].to_i)
    end_time = Time.zone.local(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i, params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i)

    @work = Work.new(start_time: start_time, end_time: end_time)

    @shift = Shift.new
    @shifts = @shift.matches(start_time, end_time)

    @users = []
    @shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end

    render :results

  end

  private

  def work_params
    params.require(:work).permit(:start_time, :end_time, :place_id, :client_id, :number_of_people)
  end

end
