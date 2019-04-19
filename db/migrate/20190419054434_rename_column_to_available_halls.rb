class RenameColumnToAvailableHalls < ActiveRecord::Migration[5.2]
  def change
    rename_column :available_halls, :user_id_id, :user_id
  end
end
