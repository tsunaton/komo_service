class CreateMachings < ActiveRecord::Migration[5.2]
  def change
    create_table :machings do |t|
      t.integer :user_id
      t.integer :work_id
      t.boolean :confirmation

      t.timestamps
    end
  end
end
