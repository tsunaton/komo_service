class CreateMachings < ActiveRecord::Migration[5.2]
  def change
    create_table :machings do |t|
      t.boolean :confirmation
      t.references :user, foreign_key: true
      t.references :funeral, foreign_key: true

      t.timestamps
    end
  end
end
