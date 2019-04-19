class AddFuneralIdToClients < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :funeral, foreign_key: true
  end
end
