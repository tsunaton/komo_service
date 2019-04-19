class ChangeColumnToShifts < ActiveRecord::Migration[5.2]
  def change
    rename_column :shifts, :start_time, :scheduled_from
    rename_column :shifts, :end_time, :scheduled_to
  end
end
