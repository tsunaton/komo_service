class Staff::HomesController < Staff::ApplicationController
  include DocumentsHelper

  def home
    works = get_works_in_month(Time.now).where(user_id: @current_user.id)

    @sum = calculate_pay_per_month(works, @current_user.pay_per_hour)

    works = works.where(status: "waiting") + works.where(status: "accepted")

    @funerals = works.inject(Array(nil)){|funerals,w| funerals << w.funeral}
  end
end
