class UpdateQuantities < ActiveRecord::Migration
  def up
    change_column :raw_material_transaction_items, :quantity, :decimal, :precision => 11, :scale => 5
    change_column :bags, :quantity, :decimal, :precision => 11, :scale => 5
    change_column :finished_good_transaction_items, :quantity, :decimal, :precision => 11, :scale => 5
    change_column :supply_transaction_items, :quantity, :decimal, :precision => 11, :scale => 5
  end

  def down
    change_column :raw_material_transaction_items, :quantity, :float
    change_column :bags, :quantity, :decimal, :float
    change_column :finished_good_transaction_items, :quantity, :float
    change_column :supply_transaction_items, :quantity, :float
  end
end
