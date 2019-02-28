class Oba::SearchingsController < ApplicationController

  def search_page
  end

  def searching

    start_time = Time.zone.local(params["start_time(1i)"].to_i, params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i, params["start_time(4i)"].to_i)
    end_time = Time.zone.local(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i, params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i)

    @shift = Shift.new
    @shifts = @shift.matches(start_time, end_time)
    respond_to do |format|
      format.html
      format.js {render 'results', shifts: @shifts}
    end
  end

end
