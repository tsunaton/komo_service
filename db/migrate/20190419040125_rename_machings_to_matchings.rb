class RenameMachingsToMatchings < ActiveRecord::Migration[5.2]
  def change
    rename_table :machings, :matchings
  end
end
