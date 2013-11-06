class AddItemFieldsToDeliveryScheduleItems < ActiveRecord::Migration
  def up
    add_column :delivery_schedule_items, :item_type, :string
    rename_column :delivery_schedule_items, :finished_good_id, :item_id
    
    DeliveryScheduleItem.update_all("item_type = 'FinishedGood'")
  end
  
  def down
    remove_column :delivery_schedule_items, :item_type
    rename_column :delivery_schedule_items, :item_id, :finished_good_id
  end
end
