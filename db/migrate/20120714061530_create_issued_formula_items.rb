class CreateIssuedFormulaItems < ActiveRecord::Migration
  def change
    create_table :issued_formula_items do |t|
      t.integer :issued_formula_id
      t.integer :raw_material_id
      t.float :big_batch_quantity
      t.float :small_batch_quantity
      t.timestamps
    end
  end
end
