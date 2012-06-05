class RemoveRrFieldsFromFgTransactions < ActiveRecord::Migration
  def up
    remove_column :finished_good_transactions, :rr_number
    remove_column :finished_good_transactions, :rr_date
  end

  def down
    add_column :finished_good_transactions, :rr_number, :string
    add_column :finished_good_transactions, :rr_date, :date
  end
end
