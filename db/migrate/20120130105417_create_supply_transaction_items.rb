class CreateSupplyTransactionItems < ActiveRecord::Migration
  def change
    create_table :supply_transaction_items do |t|
      t.float :quantity
      t.float :unit_price
      t.integer :supply_id
      t.integer :supply_transaction_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
