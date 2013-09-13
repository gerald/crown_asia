class AddFinishedGoodTransactionIdToDeliveryScheduleItems < ActiveRecord::Migration
  def change
    add_column :delivery_schedule_items, :finished_good_transaction_id, :integer
  end
end
