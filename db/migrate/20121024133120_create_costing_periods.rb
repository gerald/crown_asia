class CreateCostingPeriods < ActiveRecord::Migration
  def change
    create_table :costing_periods do |t|
      t.date :costing_date
      t.decimal :manufacturing_quote, :precision => 11, :scale => 2
      t.decimal :manufacturing_fg, :precision => 11, :scale => 2
      t.decimal :forex_quote, :precision => 11, :scale => 2
      t.decimal :forex_fg, :precision => 11, :scale => 2
      t.timestamps
    end
  end
end
