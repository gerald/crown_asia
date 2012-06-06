class AddIssuedCustomerIdToSupplyTransactions < ActiveRecord::Migration
  def change
    add_column :supply_transactions, :issued_customer_id, :integer
  end
end
