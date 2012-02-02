class UpdateBagFields < ActiveRecord::Migration
  def up
    remove_column :bags, :adding_transaction_id
  end

  def down
    add_column :bags, :adding_transaction_id, :integer
  end
end
