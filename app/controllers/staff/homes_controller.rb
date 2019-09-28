class Staff::HomesController < Staff::ApplicationController
  include DocumentsHelper

  def home
    user_works = WorkingHour.where(user_id: @current_user.id)
    done_works = user_works.where(status: "done")
    @sum = calculate_monthly(done_works, @current_user.pay_per_hour)

    accepted_works = user_works.where(status: "accepted")
    @funerals = accepted_works.inject(Array(nil)){ |funerals,w| funerals << w.funeral}
  end
end
