class AddPoNumberFieldToSupplies < ActiveRecord::Migration
  def change
    add_column :supply_transactions, :po_number, :string
  end
end
