class AddFuneralIdToFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    add_reference :funeral_halls, :funeral, foreign_key: true
  end
end
