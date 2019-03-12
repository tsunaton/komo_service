class Staff::DocumentsController < ApplicationController
  def payslip
    shifts = Shift.where(user_id: @current_user.id)
    @works = []
    shifts.each do |shift|
      works = shift.works
      @works.append(works)
    end
  end
end
