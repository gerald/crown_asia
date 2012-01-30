class AddDeletedAtToRawMaterialTransactionItems < ActiveRecord::Migration
  def change
    add_column :raw_material_transaction_items, :deleted_at, :datetime
  end
end
