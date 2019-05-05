class SetDefaultValueInWorkingHour < ActiveRecord::Migration[5.2]
  def change
    change_column_null :working_hours, :status, null: false
    change_column :working_hours, :status, :integer, default: 0
  end
end
