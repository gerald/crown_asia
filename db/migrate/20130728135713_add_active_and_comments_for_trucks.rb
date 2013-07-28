class AddActiveAndCommentsForTrucks < ActiveRecord::Migration
  def up
    add_column :trucks, :active, :boolean, :default => false
    add_column :trucks, :comments, :text
  end

  def down
    remove_column :trucks, :active
    remove_column :trucks, :comments
  end
end
