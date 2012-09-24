class AddProcessedAndCanceledToIssuedFormulaItems < ActiveRecord::Migration
  def change
    add_column :issued_formula_batches, :processed, :boolean, :default => false
    add_column :issued_formula_batches, :canceled, :boolean, :default => false
  end
end
