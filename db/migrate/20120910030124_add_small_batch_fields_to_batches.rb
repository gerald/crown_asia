class AddSmallBatchFieldsToBatches < ActiveRecord::Migration
  def change
    add_column :issued_formula_batches, :start_small_batch, :integer
    add_column :issued_formula_batches, :end_small_batch, :integer
    add_column :issued_formula_batches, :small_batch_date, :date
  end
end
