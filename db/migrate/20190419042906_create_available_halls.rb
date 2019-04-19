class CreateAvailableHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :available_halls do |t|
      t.integer :user_id
      t.integer :funeral_hall_id
    end
  end
end
