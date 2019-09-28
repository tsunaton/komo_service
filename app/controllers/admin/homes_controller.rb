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

    funerals_after_today = Funeral.where('start_time >= ?', Date.today)
    working_hours_need_transportation_fee = WorkingHour.where(transportation_fee: nil).where(status: "done")
    funerals_need_transportation_fee = working_hours_need_transportation_fee.inject(Array(nil)){|funerals, w| funerals << w.funeral}

    @funerals = funerals_after_today + funerals_need_transportation_fee
    @funerals.uniq!

  end
end
