class AddUserIdToWorkingHours < ActiveRecord::Migration[5.2]
  def change
    add_reference :working_hours, :user, foreign_key: true
  end
end
