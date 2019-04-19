class AddColumnToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :funeral_id, :integer
  end
end
