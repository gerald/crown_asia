class AddCreatorAndUpdaterToUom < ActiveRecord::Migration
  def change
    add_column :unit_of_measures, :creator_id, :integer
    add_column :unit_of_measures, :updater_id, :integer
  end
end
