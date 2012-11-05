class AddCostingToRawMaterials < ActiveRecord::Migration
  def change
    add_column :raw_materials, :costing, :boolean, :default => false
  end
end
