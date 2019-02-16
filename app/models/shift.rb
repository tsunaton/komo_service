class Shift < ApplicationRecord

  ATTRIBUTES = %i(
    searched_date
    searched_start_time
    searched_place
      )

  attr_accessor(*ATTRIBUTES)

  def matches
    t = Shift.arel_table
    results = Shift.all
    results = results.where(contains(t[:available_date], searched_date))
    #start_timeが、これ以降、で検索しないと。
    results = results.where(contains(t[:start_time], searched_start_time))
    #可能会場、このやり方じゃあかん
    results = results.where(contains(t[:available_places], searched_place))
    results

  end
end
