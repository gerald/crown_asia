class AddReferenceTypeToSupplyTransactions < ActiveRecord::Migration
  def change
    add_column :supply_transactions, :reference_type, :string
  end
end
