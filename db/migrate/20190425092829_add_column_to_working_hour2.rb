class AddColumnToWorkingHour2 < ActiveRecord::Migration[5.2]
  def change
    add_column :working_hours, :status, :integer
  end
end
