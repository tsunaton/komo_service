class CreateFuneralHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :funeral_halls do |t|
      t.string :name
      t.string :address
      t.string :nearest_station
      t.references :funeral, foreign_key: true

      t.timestamps
    end
  end
end
