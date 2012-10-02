class UpdateCanceledForIssuedFormulas < ActiveRecord::Migration
  def up
    remove_column :issued_formula_batches, :canceled
    add_column :issued_formulas, :canceled_big_batch, :boolean, :default => false
    add_column :issued_formulas, :canceled_small_batch, :boolean, :default => false
  end

  def down
    add_column :issued_formula_batches, :canceled, :boolean, :default => false
    remove_column :issued_formulas, :canceled_big_batch
    remove_column :issued_formulas, :canceled_small_batch
  end
end
