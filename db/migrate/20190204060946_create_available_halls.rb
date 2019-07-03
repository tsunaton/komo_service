class CreateAvailableHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :available_halls do |t|
      t.references :user, foreign_key: true
      t.references :funeral_hall, foreign_key: true

      t.timestamps
    end
  end
end
