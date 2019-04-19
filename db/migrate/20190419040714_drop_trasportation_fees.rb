class DropTrasportationFees < ActiveRecord::Migration[5.2]
  def change
    drop_table :transportation_fees
  end
end
