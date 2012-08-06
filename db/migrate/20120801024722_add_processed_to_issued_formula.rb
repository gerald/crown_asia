class AddProcessedToIssuedFormula < ActiveRecord::Migration
  def change
    add_column :issued_formulas, :processed, :boolean, :default => false
  end
end
