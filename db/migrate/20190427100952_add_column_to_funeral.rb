class AddColumnToFuneral < ActiveRecord::Migration[5.2]
  def change
    add_column :funerals, :family_name, :string
    add_reference :funerals, :funeral_hall, foreign_key: true
    add_reference :funerals, :client, foreign_key: true
  end
end
