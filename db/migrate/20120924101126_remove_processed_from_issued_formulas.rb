class RemoveProcessedFromIssuedFormulas < ActiveRecord::Migration
  def up
    remove_column :issued_formulas, :processed
    remove_column :issued_formulas, :canceled
  end

  def down
    add_column :issued_formulas, :processed, :boolean, :default => false
    add_column :issued_formulas, :canceled, :boolean, :default => false
  end
end
