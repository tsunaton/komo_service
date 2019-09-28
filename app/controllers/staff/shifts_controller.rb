class Staff::ShiftsController < Staff::ApplicationController

  def new
    @shift = Shift.new

    @all_shifts =
      (0..13).inject(Array(nil)){ |shifts, n|
        day = Time.now.midnight + n.days
        shifts << (7..23).inject(Array(nil)){ |times, num| times << day + num.hours}
      }

    @checked_times = Shift.where('scheduled_from >= ?', Time.now.midnight).where(user_id: @current_user)
  end

  def create
    if params[:shift]
      @checked_times = Shift.where('scheduled_from >= ?', Time.now.midnight)
      organize_and_integrate(shift_params)
    else
      render :new unless Shift.where(user_id: @current_user).delete_all
    end
    redirect_to staff_home_path, notice: 'シフトを登録しました'
  end

  def destroy
    @shift.destroy
  end

  private

  def shift_params
    @scheduled_from_params = []
    (0..7).each do |i|
      (0..16).each do |i_2|
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
      t_2 = t.split(/-|\s|:/)
      t_3 = t_2.map!(&:to_i)
      organize_and_integrate_helper(t_3[2], t_3[3], i)
      processed(@checked_times, shift_params)
    end
  end

  def organize_and_integrate_helper(date, time, i)
      #パラメータにscheduled_fromが1つしかなければ
      if shift_params.values.length == 1
        @shift = Shift.new(scheduled_from: "#{date} #{time}:00:00", scheduled_to: "#{date} #{time + 1}:00:00", user_id: @current_user.id)
        save_or_leave(@shift)
      #最後にポツンとひとつなら、そのまま保存する
      elsif @from == nil && i == shift_params.values.length - 1
        save_or_leave(@shift)

        @shift = Shift.new(scheduled_from: "#{date} #{time}:00:00", scheduled_to: "#{date} #{time + 1}:00:00", user_id: @current_user.id)
        save_or_leave(@shift)
      #開始時間が未定義なら、開始時間を定義する
      elsif @from == nil
        @from = time
        @to = time + 1
        @shift = Shift.new(scheduled_from: "#{date} #{@from}:00:00", scheduled_to: "#{date} #{@to}:00:00", user_id: @current_user.id)
      #開始時間がさっきの1時間後かつ同じ日付なら、ひとつ前の終了時間を1時間伸ばす。かつ最後のひとつなら保存する
    elsif time == @to && shift_params.values[i-1].include?(date.to_s)
        @to = @to + 1
        @shift = Shift.new(scheduled_from: "#{date} #{@from}:00:00", scheduled_to: "#{date} #{@to}:00:00", user_id: @current_user.id)
        if i == shift_params.values.length - 1
          save_or_leave(@shift)
          @from = nil
        end
      #どれにも当てはまらなければ、１つ前にnewしてあったのを保存し、@fromを空にした後、再びこのメソッドを呼ぶ
      else
        save_or_leave(@shift)
        @from = nil
        organize_and_integrate_helper(date, time, i)
      end
  end

  def save_or_leave(shift)
    if @checked_times.any?{ |ct| ct.scheduled_from == shift.scheduled_from && ct.scheduled_to == shift.scheduled_to }
      return false
    elsif ( shift_exists = @checked_times.select{ |ct| ct.scheduled_from <= shift.scheduled_from && ct.scheduled_to >= shift.scheduled_to || ct.scheduled_from >= shift.scheduled_from && ct.scheduled_to <= shift.scheduled_to || ct.scheduled_from <= shift.scheduled_from && ct.scheduled_from >= shift.scheduled_to || ct.scheduled_to <= shift.scheduled_from && ct.scheduled_to >= shift.scheduled_to }) && shift_exists.present?
      unless shift_exists[0].update(scheduled_from: shift.scheduled_from, scheduled_to: shift.scheduled_to, user_id: @current_user.id)
        render :new
      end
      shift_exists.drop(1).map{ |s| s.delete }
    else
      render :new unless shift.save
    end
  end

  def processed(checked_times, shift_params)
    @sps = []
    checked_times.each do |ct|
      shift_params.each{ |sp| t = sp[1].gsub(/-|\s|:/, ",").split(",").slice(0, 4).map(&:to_i)
        @sps << Time.zone.local(t[0],t[1],t[2],t[3]) }
      unless @sps.any?{ |sp| ct.scheduled_from <= sp && sp < ct.scheduled_to }
        ct.delete
      end
    end
  end
end
