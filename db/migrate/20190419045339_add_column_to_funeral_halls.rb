class AddColumnToFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    add_column :funeral_halls, :funeral_id, :integer
  end
end
