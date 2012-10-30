class CreateCostingPeriodItems < ActiveRecord::Migration
  def change
    create_table :costing_period_items do |t|
      t.integer :raw_material_id
      t.integer :costing_period_id
      t.decimal :quote, :precision => 11, :scale => 2
      t.decimal :fg, :precision => 11, :scale => 2
      t.timestamps
    end
  end
end
