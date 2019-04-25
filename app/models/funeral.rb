class Funeral < ApplicationRecord
  has_many :funeral_halls
  has_many :clients
  has_many :working_hours
  has_many :users, through: :working_hours

  validates :start_time, presence: true
  validates :number_of_people, presence: true, numericality: { less_than: 100 }

  accepts_nested_attributes_for :working_hours
end
