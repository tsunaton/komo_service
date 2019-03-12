class Work < ApplicationRecord
  has_many :machings
  has_many :shifts, through: :machings
end
