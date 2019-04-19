class Matching < ApplicationRecord
  belongs_to :user
  belongs_to :funeral

  with_options presence: true do
    validates :user_id
    validates :funeral_id
  end
end
