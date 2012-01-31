class AddFieldsToFinishedGood < ActiveRecord::Migration
  def change
    add_column :finished_goods, :creator_id, :integer
    add_column :finished_goods, :updater_id, :integer
  end
end
