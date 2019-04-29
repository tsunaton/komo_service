class Admin::FuneralsController < Admin::ApplicationController

  def index
    @funerals = Funeral.all
  end

  def new
    start_time = Time.zone.parse(params[:start_date] + " " + params[:start_time])
    quickest_end_time = start_time + 4.hours

    @shift = Shift.new
    @shifts = @shift.matches(start_time, quickest_end_time)
    @users = []
    @shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end

    @funeral = Funeral.new(start_time: start_time, number_of_people: params[:number_of_people])
    @hall_name = FuneralHall.find(params[:funeral_hall]).name
    @clients = Client.all
  end

  def create
    funeral = Funeral.new(funeral_params)
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
    params.require(:funeral).permit(:id, :funeral_halls_id, :client_id, :start_time, :end_time, working_hours_attributes:['0': :shift_id] )
    end

end
