class Funeral < ApplicationRecord
  has_many :working_hours
  has_many :users, through: :working_hours
  belongs_to :funeral_hall
  belongs_to :client

  validates :start_time, presence: true
  validates :number_of_people, presence: true, numericality: { less_than: 100 }
  validates :family_name, presence: true, length: { maximum: 50 }

  accepts_nested_attributes_for :working_hours

  default_scope -> { order(start_time: :desc) }

  def done?
    self.working_hours.all? {|w| w.status == ("done" || "rejected")}
  end

  def done?(staff)
    this_staffs_work = self.working_hours.find_by(user_id: staff.id)
    this_staffs_work.status == "done"
  end
end
