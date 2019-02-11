class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :place_id
      t.integer :client_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :number_of_people

      t.timestamps
    end
  end
end
