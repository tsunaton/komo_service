class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.datetime :scheduled_from
      t.datetime :scheduled_to
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
