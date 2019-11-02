class RemoveTransportationFeeFromWorkingHours < ActiveRecord::Migration[5.2]
  def change
    remove_column :working_hours, :transportation_fee, :integer
  end
end
