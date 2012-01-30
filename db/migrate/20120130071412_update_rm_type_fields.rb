class UpdateRmTypeFields < ActiveRecord::Migration
  def up
    remove_column :raw_material_types, :name
    add_column :raw_material_types, :creator_id, :integer
    add_column :raw_material_types, :updater_id, :integer
  end

  def down
    add_column :raw_material_types, :name, :string
    remove_column :raw_material_types, :creator_id
    remove_column :raw_material_types, :updater_id
  end
end
