class AddReturnFieldsToFgTransaction < ActiveRecord::Migration
  def change
    add_column :finished_good_transactions, :rr_number, :string
    add_column :finished_good_transactions, :rr_date, :date
  end
end
