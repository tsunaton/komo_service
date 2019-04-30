class WorkingHour < ApplicationRecord
belongs_to :user
belongs_to :funeral

validates :status, presence: true
end
