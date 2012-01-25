class AddQuantityPerBagToFinishedGoodTransactions < ActiveRecord::Migration
  def change
    add_column :finished_good_transactions, :quantity_per_bag, :float
  end
end
