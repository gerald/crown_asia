class AddSiToDeliveryScheduleItems < ActiveRecord::Migration
  def change
    add_column :delivery_schedule_items, :si, :string
  end
end
