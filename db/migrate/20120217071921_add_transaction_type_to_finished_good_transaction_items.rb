class AddTransactionTypeToFinishedGoodTransactionItems < ActiveRecord::Migration
  def change
    add_column :finished_good_transaction_items, :transaction_type, :string
  end
end
