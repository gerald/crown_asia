class CreateSupplyTransactions < ActiveRecord::Migration
  def change
    create_table :supply_transactions do |t|
      t.string :transaction_type
      t.date :transaction_date
      t.float :quantity
      t.string :supplier_name
      t.float :unit_price
      t.string :usage
      t.string :rr_number
      t.string :pre_number
      t.string :mirs_number
      t.string :lot_number
      t.integer :supply_id
      t.integer :issued_department_id
      t.integer :issued_user_id
      t.text :comments
      t.integer :creator_id
      t.integer :updater_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
