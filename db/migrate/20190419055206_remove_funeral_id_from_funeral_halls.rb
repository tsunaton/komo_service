class RemoveFuneralIdFromFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    remove_column :funeral_halls, :funeral_id, :integer
  end
end
