class CreateFinishedGoodTransactions < ActiveRecord::Migration
  def change
    create_table :finished_good_transactions do |t|
      t.string :transaction_type
      t.string :reference_type
      t.string :reference_number
      t.date :transaction_date
      t.float :quantity
      t.string :lot_number
      t.string :dr_number
      t.string :si_number
      t.integer :start_bag_number
      t.integer :end_bag_number
      t.integer :finished_good_id
      t.integer :sender_id
      t.string :sender_type
      t.text :comments
      t.integer :creator_id
      t.integer :updater_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
