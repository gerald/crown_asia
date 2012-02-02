class CreateFinishedGoodTransactionItems < ActiveRecord::Migration
  def change
    create_table :finished_good_transaction_items do |t|
      t.string :lot_number
      t.integer :start_bag_number
      t.integer :end_bag_number
      t.float :quantity
      t.boolean :underpack, :default => false
      t.integer :finished_good_transaction_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
