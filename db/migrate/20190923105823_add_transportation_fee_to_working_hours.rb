class AddTransportationFeeToWorkingHours < ActiveRecord::Migration[5.2]
  def change
    add_column :working_hours, :transportation_fee, :integer
  end
end
