class RenameMailToEmail < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :mail, :email
  end
end
