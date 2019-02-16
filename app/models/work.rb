class Work < ApplicationRecord
  has_many :machings
    has_many :users, through: :machings
end
