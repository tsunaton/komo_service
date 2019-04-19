class RenamePlacesToFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    rename_table :places, :funeral_halls
  end
end
