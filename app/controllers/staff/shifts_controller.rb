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
    @times = (7..22)
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def create
    organize_and_integrate(shift_params)
    redirect_to staff_shifts_path
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
    @scheduled_from_params = []
    (0..7).each do |i|
      (0..15).each do |i_2|
        scheduled_from = "scheduled_from#{i}-#{i_2}"
        @scheduled_from_params.append(scheduled_from)
      end
    end
    params
      .require(:shift)
      .permit(@scheduled_from_params)
  end

  def organize_and_integrate(shift_params)
    @from = nil
    shift_params.values.each_with_index do |t, i|
      /(.+):(\d+)/ =~ t
      organize_and_integrate_helper($1, $2, i)
    end
  end

  def organize_and_integrate_helper(date, time, i)
    #最後にポツンとひとつなら、そのまま保存する。
    if @from == nil && i == shift_params.values.length - 1
      render :new unless @shift.save
      @shift = Shift.create(scheduled_from: "#{date} #{time}:00:00", scheduled_to: "#{date} #{time.to_i + 1}:00:00", user_id: @current_user.id)
    #開始時間が未定義なら、開始時間を定義する。
    elsif @from == nil
      @from = time.to_i
      @to = time.to_i + 1
      @shift = Shift.new(scheduled_from: "#{date} #{@from}:00:00", scheduled_to: "#{date} #{@to}:00:00", user_id: @current_user.id)
    #開始時間がさっきの1時間後かつ同じ日付なら、ひとつ前の終了時間を1時間伸ばす。かつ最後のひとつなら保存する。
    elsif time.to_i == @to && shift_params.values[i-1].include?(date)
      @to = @to + 1
      @shift = Shift.new(scheduled_from: "#{date} #{@from}:00:00", scheduled_to: "#{date} #{@to}:00:00", user_id: @current_user.id)
      if i == shift_params.values.length - 1
        render :new unless @shift.save
        @from = nil
      end
    #どれにも当てはまらなければ、１つ前にnewしてあったのを保存し、@fromを空にした後、再びこのメソッドを呼ぶ。
    else
      render :new unless @shift.save
      @from = nil
      organize_and_integrate_helper(date, time, i)
    end
  end
end
