class AddColumnToUser3 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pay_per_hour, :integer
  end
end
