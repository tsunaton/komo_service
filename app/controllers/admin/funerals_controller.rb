class Admin::FuneralsController < Admin::ApplicationController

  def index
    @funerals = Funeral.all
  end

  def new
    start_time = Time.zone.local(params["start_time(1i)"].to_i, params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(5i)"].to_i)
    end_time = Time.zone.local(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i, params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i)
    @funeral = Funeral.new(start_time: start_time, end_time: end_time)
    @shift = Shift.new
    @shifts = @shift.matches(start_time, end_time)

    @users = []
    @shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end
  end

  def create
    funeral = Funeral.new(funeral_params)
    binding.pry
    if funeral.save!
      redirect_to admin_funerals_path
    else
      render :new
    end
  end

  def edit
    @funeral = Funeral.find(params[:id])
    @users = []
    @funeral.shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end
  end

  def update
    funeral = Funeral.find(params[:id])
    if funeral.update(funeral_params)
      redirect_to admin_funerals_path
    else
      render :edit
    end
  end

  def search_page
    t = Date.today
    @days = (t..(t + 7)).to_a

    @halls = FuneralHall.all
  end

  def destroy
  end

  private

    def funeral_params
    params.require(:funeral).permit(:id, :funeral_halls_id, :client_id, :start_time, :end_time, machings_attributes:["0": :shift_id] )
    end

end
