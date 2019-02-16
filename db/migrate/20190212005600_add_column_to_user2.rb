class AddColumnToUser2 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :available_place, :string
    add_column :users, :remember_digest, :string
  end
end
