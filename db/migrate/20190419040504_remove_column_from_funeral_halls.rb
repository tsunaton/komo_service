class RemoveColumnFromFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    remove_column :funeral_halls, :work_id, :integer
  end
end
