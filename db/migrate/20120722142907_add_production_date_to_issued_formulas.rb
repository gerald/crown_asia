class AddProductionDateToIssuedFormulas < ActiveRecord::Migration
  def change
    add_column :issued_formulas, :production_date, :date
  end
end
