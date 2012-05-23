class AddFieldsToRmTransaction < ActiveRecord::Migration
  def change
    add_column :raw_material_transactions, :issue_type, :string
    add_column :raw_material_transactions, :issued_to_id, :integer
    add_column :raw_material_transactions, :issued_to_type, :string
    add_column :raw_material_transactions, :dr_number, :string
    add_column :raw_material_transactions, :si_number, :string
  end
end
