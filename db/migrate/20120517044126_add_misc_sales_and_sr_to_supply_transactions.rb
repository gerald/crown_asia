class AddMiscSalesAndSrToSupplyTransactions < ActiveRecord::Migration
  def change
    add_column :supply_transactions, :misc_sales_number, :string
    add_column :supply_transactions, :sr_number, :string
  end
end
