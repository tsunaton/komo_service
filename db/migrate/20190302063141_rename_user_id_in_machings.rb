class RenameUserIdInMachings < ActiveRecord::Migration[5.2]
  def change
    rename_column :machings, :user_id, :shift_id
  end
end
