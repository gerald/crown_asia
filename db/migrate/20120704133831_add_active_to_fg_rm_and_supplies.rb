class AddActiveToFgRmAndSupplies < ActiveRecord::Migration
  def change
    add_column :finished_goods, :active, :boolean, :default => true
    add_column :raw_materials, :active, :boolean, :default => true
    add_column :supplies, :active, :boolean, :default => true
  end
end
