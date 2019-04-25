class Funeral < ApplicationRecord
  has_many :funeral_halls
  has_many :clients
  has_many :machings
  has_many :shifts, through: :machings

  validates :start_time, presence: true
  validates :number_of_people, presence: true, numericality: { less_than: 100 }

  accepts_nested_attributes_for :machings
end
