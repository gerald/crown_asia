class CreateRawMaterialTransactions < ActiveRecord::Migration
  def change
    create_table :raw_material_transactions do |t|
      t.string :transaction_type
      t.string :reference_type
      t.string :reference_number
      t.date :transaction_date
      t.float :quantity
      t.string :lot_number
      t.string :po_number
      t.string :mirs_number
      t.integer :raw_material_id
      t.integer :issued_department_id
      t.integer :sender_id
      t.string :sender_type
      t.text :comments
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
