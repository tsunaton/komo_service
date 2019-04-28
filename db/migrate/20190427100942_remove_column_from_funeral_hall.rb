class RemoveColumnFromFuneralHall < ActiveRecord::Migration[5.2]
  def change
    remove_reference :funeral_halls, :funeral, foreign_key: true
  end
end
