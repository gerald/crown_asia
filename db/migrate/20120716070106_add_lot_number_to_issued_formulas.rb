class AddLotNumberToIssuedFormulas < ActiveRecord::Migration
  def change
    add_column :issued_formulas, :lot_number, :string
  end
end
