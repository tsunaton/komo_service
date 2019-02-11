class CreateTransportationFees < ActiveRecord::Migration[5.2]
  def change
    create_table :transportation_fees do |t|
      t.integer :user_id
      t.integer :place_id

      t.timestamps
    end
  end
end
