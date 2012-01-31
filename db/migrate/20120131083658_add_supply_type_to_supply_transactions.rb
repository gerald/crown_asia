class AddSupplyTypeToSupplyTransactions < ActiveRecord::Migration
  def change
    add_column :supply_transactions, :supply_type, :string
  end
end
