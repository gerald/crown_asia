class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :name
      t.string :code
      t.string :supply_type
      t.text :description
      t.text :comments
      t.integer :unit_of_measure_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
