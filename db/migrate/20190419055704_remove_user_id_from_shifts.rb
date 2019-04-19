class RemoveUserIdFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :user_id, :integer
  end
end
