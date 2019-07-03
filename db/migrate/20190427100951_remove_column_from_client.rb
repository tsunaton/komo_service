class RemoveColumnFromClient < ActiveRecord::Migration[5.2]
  def change
    remove_reference :clients, :funeral, foreign_key: true
  end
end
