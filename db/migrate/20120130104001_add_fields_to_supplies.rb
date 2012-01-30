class AddFieldsToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :creator_id, :integer
    add_column :supplies, :updater_id, :integer
  end
end
