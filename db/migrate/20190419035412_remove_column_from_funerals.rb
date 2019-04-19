class RemoveColumnFromFunerals < ActiveRecord::Migration[5.2]
  def change
    remove_column :funerals, :end_time, :datetime
  end
end
