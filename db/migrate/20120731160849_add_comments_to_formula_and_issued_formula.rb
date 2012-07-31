class AddCommentsToFormulaAndIssuedFormula < ActiveRecord::Migration
  def change
    add_column :formulas, :comments, :text
    add_column :issued_formulas,:comments, :text
  end
end
