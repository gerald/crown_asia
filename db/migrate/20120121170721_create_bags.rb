class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|
      t.integer :bag_number
      t.integer :adding_transaction_id
      t.integer :removing_transaction_id
      t.integer :finished_good_id
      t.float :quantity
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
