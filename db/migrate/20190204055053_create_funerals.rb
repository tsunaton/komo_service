class CreateFunerals < ActiveRecord::Migration[5.2]
  def change
    create_table :funerals do |t|
      t.integer :number_of_people
      t.datetime :start_time
      
      t.timestamps
    end
  end
end
