class AddCreatorAndUpdaterToRawMaterialTransactions < ActiveRecord::Migration
  def change
    add_column :raw_material_transactions, :creator_id, :integer
    add_column :raw_material_transactions, :updater_id, :integer
  end
end
