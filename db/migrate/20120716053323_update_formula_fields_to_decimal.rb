class UpdateFormulaFieldsToDecimal < ActiveRecord::Migration
  def up
    change_column :formula_items, :quantity, :decimal, :precision => 11, :scale => 5
    change_column :formula_items, :multiplier, :decimal, :precision => 11, :scale => 5
    change_column :issued_formulas, :resin_big_batch_quantity, :decimal, :precision => 11, :scale => 5
    change_column :issued_formulas, :resin_small_batch_quantity, :decimal, :precision => 11, :scale => 5
    change_column :issued_formulas, :big_batch_quantity, :decimal, :precision => 11, :scale => 5
    change_column :issued_formulas, :small_batch_quantity, :decimal, :precision => 11, :scale => 5
    change_column :issued_formula_items, :big_batch_quantity, :decimal, :precision => 11, :scale => 5
    change_column :issued_formula_items, :small_batch_quantity, :decimal, :precision => 11, :scale => 5
  end

  def down
    change_column :formula_items, :quantity, :float
    change_column :formula_items, :multiplier, :float
    change_column :issued_formulas, :resin_big_batch_quantity, :float
    change_column :issued_formulas, :resin_small_batch_quantity, :float
    change_column :issued_formulas, :big_batch_quantity, :float
    change_column :issued_formulas, :small_batch_quantity, :float
    change_column :issued_formula_items, :big_batch_quantity, :float
    change_column :issued_formula_items, :small_batch_quantity, :float
  end
end
