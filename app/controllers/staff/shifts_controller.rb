class Staff::ShiftsController < ApplicationController
  # before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    @shifts = Shift.all
  end

  def show
  end

  def new
    @shift = Shift.new
  end

  def edit
    @user = User.find(params[:id])
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
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
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
