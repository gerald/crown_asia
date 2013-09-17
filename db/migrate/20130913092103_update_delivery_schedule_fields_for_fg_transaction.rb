class UpdateDeliveryScheduleFieldsForFgTransaction < ActiveRecord::Migration
  def up
    add_column :finished_good_transactions, :delivery_schedule_item_id, :integer
    remove_column :delivery_schedule_items, :finished_good_transaction_id
  end

  def down
    remove_column :finished_good_transactions, :delivery_schedule_item_id
    add_column :delivery_schedule_items, :finished_good_transaction_id, :integer
  end
end
