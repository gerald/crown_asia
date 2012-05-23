class RenameSupplierNameFieldInSupplyTransactions < ActiveRecord::Migration
  def up
    rename_column :supply_transactions, :supplier_name, :supplier_id
    change_column :supply_transactions, :supplier_id, :integer
  end

  def down
    rename_column :supply_transactions, :supplier_id, :supplier_name
    change_column :supply_transactions, :supplier_name, :string
  end
end
