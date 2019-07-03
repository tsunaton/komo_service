class AddColumnToWorkingHour < ActiveRecord::Migration[5.2]
  def change
    add_reference :working_hours, :funeral, foreign_key: true
  end
end
