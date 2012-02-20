class RemoveLotNumberFromFinishedGoodTransactions < ActiveRecord::Migration
  def up
    remove_column :finished_good_transactions, :lot_number
  end

  def down
    add_column :finished_good_transactions, :lot_number, :string
  end
end
