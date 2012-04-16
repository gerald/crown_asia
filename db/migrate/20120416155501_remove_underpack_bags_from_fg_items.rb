class RemoveUnderpackBagsFromFgItems < ActiveRecord::Migration
  def up
    remove_column :finished_good_transaction_items, :underpack_bags
  end

  def down
    add_column :finished_good_transaction_items, :underpack_bags, :text
  end
end
