class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :address
      t.string :nearest_station
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
