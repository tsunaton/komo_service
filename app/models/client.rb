class Client < ApplicationRecord
belongs_to :funeral

validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
validates :address, length: { maximum: 50 }, uniqueness: true
validates :dispatching_fee_per_hour, numericality: { less_than: 10000 }
end
