class AddFieldsToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :active, :boolean, :default => false
    add_column :suppliers, :creator_id, :integer
    add_column :suppliers, :updater_id, :integer
  end
end
