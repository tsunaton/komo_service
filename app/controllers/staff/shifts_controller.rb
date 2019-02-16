class Staff::ShiftsController < ApplicationController
before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @shifts = Shift.all
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
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def shift_params
      params
        .require(:shift)
        .permit(:start_time, :end_time)
    end
end
