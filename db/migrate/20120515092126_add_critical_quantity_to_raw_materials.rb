class AddCriticalQuantityToRawMaterials < ActiveRecord::Migration
  def change
    add_column :raw_materials, :critical_quantity, :decimal, :precision => 11, :scale => 5
  end
end
