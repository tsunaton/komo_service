class Oba::WorksController < ApplicationController

  def index
    @works = Form::Work.all
  end

  def new
    @work = Form::Work.new
  end

  def create
    work = Form::Work.new(work_params)
    if work.save
      redirect_to oba_works_path
    else
      render :new
    end
  end

  def edit
    @work = Form::Work.find(params[:id])
    @users = User.find(@work.shifts[0].user_id)
  end

  def update
    work = Form::Work.find(params[:id])
    if work.update(work_params)
      redirect_to oba_works_path
    else
      render :edit
    end
  end

  def search_page
  end

  def destroy
  end

  def search

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

    render :new

  end

  private

    def work_params
    params
      .require(:work)
      .permit(
        Form::Work::REGISTRABLE_ATTRIBUTES +
        [machings_attributes: Form::Maching::REGISTRABLE_ATTRIBUTES]
      )
    end

end
