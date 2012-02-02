class AddFinishedGoodTransactionItemIdToBag < ActiveRecord::Migration
  def change
    add_column :bags, :finished_good_transaction_item_id, :integer
  end
end
