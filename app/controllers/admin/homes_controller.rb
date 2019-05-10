class Admin::HomesController < Admin::ApplicationController
  include DocumentsHelper

  def home
    come =
      Client.all.inject(0){ |total, c|
      works = WorkingHour.where(funeral_id: c.funerals.ids).where(status: "done")
      sub_total = calculate_monthly(works, c.dispatching_fee_per_hour)
      total += sub_total}

    go =

      User.all.inject(0){ |total, u|
      works = WorkingHour.where(user_id: u.id).where(status: "done")
      sub_total = calculate_monthly(works, u.pay_per_hour)
      total += sub_total}

    @sum = come - go

    @funerals = Funeral.where('start_time >= ?', Date.today)
  end
end
