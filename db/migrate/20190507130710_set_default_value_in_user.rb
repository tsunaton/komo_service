class SetDefaultValueInUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :user_type, null: false
    change_column :users, :user_type, :integer, default: 0
  end
end
