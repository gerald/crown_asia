class CreateDeliveryScheduleItems < ActiveRecord::Migration
  def change
    create_table :delivery_schedule_items do |t|
      t.string :po
      t.string :so
      t.decimal :quantity, :precision => 11, :scale => 2
      t.integer :customer_id
      t.integer :finished_good_id
      t.integer :delivery_schedule_id
      t.timestamps
    end
  end
end
