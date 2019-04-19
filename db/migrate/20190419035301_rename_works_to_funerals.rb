class RenameWorksToFunerals < ActiveRecord::Migration[5.2]
  def change
    rename_table :works, :funerals
  end
end
