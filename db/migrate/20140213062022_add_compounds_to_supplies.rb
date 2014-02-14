class AddCompoundsToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :compounds, :boolean, :default => false
    add_column :supplies, :pipes, :boolean, :default => false
    add_column :supplies, :corporate, :boolean, :default => false
  end
end
