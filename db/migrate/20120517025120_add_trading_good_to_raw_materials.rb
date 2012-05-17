class AddTradingGoodToRawMaterials < ActiveRecord::Migration
  def change
    add_column :raw_materials, :trading_good, :boolean, :default => false
  end
end
