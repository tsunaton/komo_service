class AddReferencesToMatchings < ActiveRecord::Migration[5.2]
  def change
    add_reference :available_halls, :user, foreign_key: true
    add_reference :available_halls, :funeral, foreign_key: true
  end
end
