class Staff::DocumentsController < Staff::ApplicationController
  def payslip
    shifts = Shift.where(user_id: @current_user.id)
    @funerals = []
    shifts.each do |shift|
      funerals = shift.funerals
      @funerals.append(funerals)
    end
  end
end
