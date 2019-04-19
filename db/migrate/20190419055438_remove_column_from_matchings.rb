class RemoveColumnFromMatchings < ActiveRecord::Migration[5.2]
  def change
    remove_column :matchings, :shift_id, :integer
    remove_column :matchings, :work_id, :integer
  end
end
