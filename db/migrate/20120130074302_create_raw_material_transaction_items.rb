class CreateRawMaterialTransactionItems < ActiveRecord::Migration
  def change
    create_table :raw_material_transaction_items do |t|
      t.string :lot_number
      t.float :quantity
      t.integer :raw_material_transaction_id
      t.timestamps
    end
  end
end
