class Staff::ShiftsController < Staff::ApplicationController
before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @shifts = Shift.where(user_id: @current_user)
  end

  def show
  end

  def new
    @shift = Shift.new
    t = Date.today
    @days = (t..(t + 7)).to_a

    @hours = []
    @days.each do |day|
      @hoge = []
      (7..22).each do |t|
        hour = Shift.new(scheduled_from: "#{day} #{t}:00:00", scheduled_to: "#{day} #{t+1}:00:00", user_id: 1)
        @hoge.append(hour)
      end
      @hours.append(@hoge)
    end
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.user_id = @current_user.id
    if @shift.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def update
    shift = Shift.find(params[:id])
    if shift.update(shift_params)
      redirect_to staff_shifts_path
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
  end

  private
    def shift_params
      params
        .require(:shift)
        .permit(:start_time, :end_time)
    end
end
