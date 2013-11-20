class AddCreatorAndUpdaterForCoq < ActiveRecord::Migration
  def up
    add_column :certificate_of_qualities, :creator_id, :integer
    add_column :certificate_of_qualities, :updater_id, :integer
    add_column :certificate_of_quality_items, :creator_id, :integer
    add_column :certificate_of_quality_items, :updater_id, :integer
  end

  def down
    remove_column :certificate_of_qualities, :creator_id
    remove_column :certificate_of_qualities, :updater_id
    remove_column :certificate_of_quality_items, :creator_id
    remove_column :certificate_of_quality_items, :updater_id
  end
end
