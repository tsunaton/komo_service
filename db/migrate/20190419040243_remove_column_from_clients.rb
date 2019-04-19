class RemoveColumnFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :work_id, :integer
  end
end
