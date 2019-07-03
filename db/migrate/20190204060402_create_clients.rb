class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.integer :dispatching_fee_per_hour
      t.references :funeral, foreign_key: true

      t.timestamps
    end
  end
end
