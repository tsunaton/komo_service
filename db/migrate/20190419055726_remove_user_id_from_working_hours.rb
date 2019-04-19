class RemoveUserIdFromWorkingHours < ActiveRecord::Migration[5.2]
  def change
    remove_column :working_hours, :user_id, :integer
  end
end
