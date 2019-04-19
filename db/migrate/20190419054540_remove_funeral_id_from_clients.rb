class RemoveFuneralIdFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :funeral_id, :integer
  end
end
