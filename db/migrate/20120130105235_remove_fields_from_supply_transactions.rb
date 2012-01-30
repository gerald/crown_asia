class RemoveFieldsFromSupplyTransactions < ActiveRecord::Migration
  def up
    remove_column :supply_transactions, :quantity
    remove_column :supply_transactions, :unit_price
    remove_column :supply_transactions, :supply_id
  end

  def down
    add_column :supply_transactions, :quantity, :float
    add_column :supply_transactions, :unit_price, :float
    add_column :supply_transactions, :supply_id, :integer
  end
end
