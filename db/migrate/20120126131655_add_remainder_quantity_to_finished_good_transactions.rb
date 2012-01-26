class AddRemainderQuantityToFinishedGoodTransactions < ActiveRecord::Migration
  def change
    add_column :finished_good_transactions, :remainder_quantity, :float
  end
end
