class AddIssuedToFinishedGoodTransaction < ActiveRecord::Migration
  def change
    add_column :finished_good_transactions, :issue_type, :string
    add_column :finished_good_transactions, :issued_to_id, :integer
    add_column :finished_good_transactions, :issued_to_type, :string
    add_column :finished_good_transactions, :mirs_number, :string
  end
end
