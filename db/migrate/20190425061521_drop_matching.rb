class DropMatching < ActiveRecord::Migration[5.2]
  def change
    drop_table :machings
  end
end
