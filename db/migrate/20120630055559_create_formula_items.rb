class CreateFormulaItems < ActiveRecord::Migration
  def change
    create_table :formula_items do |t|
      t.float :quantity
      t.float :multiplier
      t.integer :formula_id
      t.integer :raw_material_type_id
      t.integer :raw_material_id
      t.timestamps
    end
  end
end
