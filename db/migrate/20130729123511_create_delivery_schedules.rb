class CreateDeliverySchedules < ActiveRecord::Migration
  def change
    create_table :delivery_schedules do |t|
      t.string :control_number
      t.date :delivery_date
      t.time :delivery_time
      t.text :comments
      t.text :cancel_reason
      t.integer :truck_id
      t.integer :driver_id
      t.integer :delivery_helper_1_id
      t.integer :delivery_helper_2_id
      t.timestamps
    end
  end
end
