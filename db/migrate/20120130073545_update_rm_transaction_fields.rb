class UpdateRmTransactionFields < ActiveRecord::Migration
  def up
    remove_column :raw_material_transactions, :quantity
    remove_column :raw_material_transactions, :lot_number
  end

  def down
    add_column :raw_material_transactions, :quantity, :float
    add_column :raw_material_transactions, :lot_number, :string
  end
end
