class CreateIssuedFormulaBatches < ActiveRecord::Migration
  def change
    create_table :issued_formula_batches do |t|
      t.integer :start_batch
      t.integer :end_batch
      t.date :batch_date
      t.integer :issued_formula_id
      t.timestamps
    end
  end
end
