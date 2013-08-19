class AddSelectedForDeliveryScheduleItems < ActiveRecord::Migration
  def up
    add_column :delivery_schedule_items, :selected, :boolean, :default => false
  end

  def down
    remove_column :delivery_schedule_items, :selected
  end
end
