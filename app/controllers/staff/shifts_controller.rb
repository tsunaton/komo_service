class Staff::ShiftsController < Staff::Base
before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @shifts = Shift.where(user_id: @current_user)
  end

  def show
  end

  def new
    @shift = Shift.new
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
