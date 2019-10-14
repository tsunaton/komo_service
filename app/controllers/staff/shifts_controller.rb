class Staff::ShiftsController < Staff::ApplicationController

  def new
    @shift = Shift.new

    today=Time.current
  	@days = Array.new
    @days << today

  	13.times do
  	  today = today.tomorrow
  	  @days << today
    end

    @hours = Array.new
    @hash = Hash.new do |hsh, key|
      shifts = Shift.where("scheduled_from >= ?", key.beginning_of_day)
                    .where("scheduled_to <= ?", key.end_of_day )
      shifts.each do |shift|
        start_hour = shift.scheduled_from.hour.to_i
        end_hour = shift.scheduled_to.hour.to_i
        end_hour = end_hour - 1
        @hours << (start_hour .. end_hour)
      end
      hsh[key] = @hours
      @hours = Array.new
    end
  end

  def create
    
    if params[:shift].present?
      Shift.all.delete_all

      @@start_time = nil
      @@end_time = nil

      shift_params.values.each do |hour|
        hour = hour.to_datetime
        user_id = @current_user.id
        save_shifts(user_id, @@start_time, @@end_time, hour)
      end
    end
    unless params[:whole_day].nil?
      shifts = Shift.where("scheduled_from >= ?", whole_day_params.to_datetime.beginning_of_day)
                    .where("scheduled_to <= ?", whole_day_params.to_datetime.end_of_day )
      shifts.all.delete_all
      Shift.create(user_id: @current_user.id, scheduled_from: whole_day_params.to_datetime.change(hour: 7), scheduled_to: whole_day_params.to_datetime.change(hour: 23))
    end
      redirect_to new_staff_shift_path
  end

  def destroy
    @shift.destroy
  end

  private

  def save_shift(user_id, start_time, end_time, hour)
    shift = Shift.new(user_id: user_id,
                      scheduled_from: @@start_time.to_datetime,
                      scheduled_to: @@end_time.to_datetime.since(1.hour))
    if shift.save
      @@start_time = hour.to_datetime
      @@end_time = hour.to_datetime.since(1.hour)
    else
      render new_staff_shift_path, alert: “シフトの保存に失敗しました”
    end
  end

  def save_reset_restart(user_id, start_time, end_time, hour)
    save_shift(user_id, start_time, @@end_time, hour)
    @@start_time = nil
    @@end_time = nil
    save_shifts(user_id, @@start_time, @@end_time, hour)
  end

  def save_shifts(user_id, start_time, end_time, hour)
    if hour == shift_params.values.last
      if @@start_time.present?
        if hour == @@end_time.since(1.hour)
          @@end_time = hour
          save_shift(user_id, @@start_time, @@end_time, hour)
        else
          save_reset_restart(user_id, @@start_time, @@end_time, hour)
        end
      else
        @@end_time =  hour
        if @@start_time.nil?
          @@start_time = hour
        end
        save_shift(user_id, @@start_time, @@end_time, hour)
      end
    elsif @@start_time.present?
      if hour == @@end_time.since(1.hour)
        @@end_time = hour
      else
        save_reset_restart(user_id, @@start_time, @@end_time, hour)
      end
    else
      @@start_time = hour
      @@end_time = hour
    end
  end

  def whole_day_params
    params.require(:whole_day)
  end

  def shift_params
    @scheduled_from_params = []
    (1..31).each do |day|
      (7..22).each do |hour|
        ch_box_name = "#{day}-#{hour}"
        @scheduled_from_params.append(ch_box_name)
      end
    end
    params
      .require(:shift)
      .permit(@scheduled_from_params)
  end
end
