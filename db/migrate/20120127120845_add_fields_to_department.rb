class AddFieldsToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :active, :boolean, :default => true
    add_column :departments, :creator_id, :integer
    add_column :departments, :updater_id, :integer
  end
end
