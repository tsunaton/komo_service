class Funeral < ApplicationRecord
  has_many :funeral_halls
  has_many :clients
  has_many :machings
  has_many :shifts, through: :machings

  accepts_nested_attributes_for :machings
end
