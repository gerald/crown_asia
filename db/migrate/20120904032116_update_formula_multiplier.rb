class UpdateFormulaMultiplier < ActiveRecord::Migration
  def up
    change_column :formula_items, :multiplier, :decimal, :precision => 11, :scale => 8
  end

  def down
    change_column :formula_items, :multiplier, :decimal, :precision => 11, :scale => 5
  end
end
