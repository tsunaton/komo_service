class WorkingHour < ApplicationRecord
belongs_to :user
belongs_to :funeral

validates :start_time, presence: true
end
