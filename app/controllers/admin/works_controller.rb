class Admin::WorksController < Admin::ApplicationController

  def index
    @works = Work.all
  end

  def new
    start_time = Time.zone.local(params["start_time(1i)"].to_i, params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(5i)"].to_i)
    end_time = Time.zone.local(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i, params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i)
    @work = Work.new(start_time: start_time, end_time: end_time)
    @shift = Shift.new
    @shifts = @shift.matches(start_time, end_time)

    @users = []
    @shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end
  end

  def create
    work = Work.new(work_params)
    binding.pry
    if work.save!
      redirect_to admin_works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
    @users = []
    @work.shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end
  end

  def update
    work = Work.find(params[:id])
    if work.update(work_params)
      redirect_to admin_works_path
    else
      render :edit
    end
  end

  def search_page
  end

  def destroy
  end

  private

    def work_params
    params.require(:work).permit(:id, :place_id, :client_id, :start_time, :end_time, machings_attributes:["0": :shift_id] )
    end

end