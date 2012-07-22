class AddCanceledToIssuedFormulas < ActiveRecord::Migration
  def change
    add_column :issued_formulas, :canceled, :boolean, :default => false
  end
end
