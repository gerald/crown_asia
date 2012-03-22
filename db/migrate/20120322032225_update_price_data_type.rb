class UpdatePriceDataType < ActiveRecord::Migration
  def up
    change_column :supply_transaction_items, :unit_price, :decimal, :precision => 11, :scale => 5
  end

  def down
    change_column :supply_transaction_items, :unit_price, :float
  end
end
