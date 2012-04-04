class AddUnderpackBagsToFinishedGoodTransactionItem < ActiveRecord::Migration
  def change
    add_column :finished_good_transaction_items, :underpack_bags, :text
  end
end
