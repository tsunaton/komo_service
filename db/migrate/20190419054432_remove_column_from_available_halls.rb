class RemoveColumnFromAvailableHalls < ActiveRecord::Migration[5.2]
  def change
    remove_column :available_halls, :user_id, :integer
  end
end
