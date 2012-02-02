class UpdateFinishedGoodTransactionFields < ActiveRecord::Migration
  def up
    remove_column :finished_good_transactions, :start_bag_number
    remove_column :finished_good_transactions, :end_bag_number
    remove_column :finished_good_transactions, :remainder_quantity
    remove_column :finished_good_transactions, :quantity
  end

  def down
    add_column :finished_good_transactions, :start_bag_number, :integer
    add_column :finished_good_transactions, :end_bag_number, :integer
    add_column :finished_good_transactions, :remainder_quantity, :float
    add_column :finished_good_transactions, :quantity, :float
  end
end
