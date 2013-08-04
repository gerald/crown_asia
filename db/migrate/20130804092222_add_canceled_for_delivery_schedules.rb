class AddCanceledForDeliverySchedules < ActiveRecord::Migration
  def up
    add_column :delivery_schedules, :canceled, :boolean, :default => false
  end

  def down
    remove_column :delivery_schedules, :canceled
  end
end
