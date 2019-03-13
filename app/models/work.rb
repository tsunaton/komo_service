class Work < ApplicationRecord
  has_many :machings
  has_many :shifts, through: :machings
  accepts_nested_attributes_for :machings
end
