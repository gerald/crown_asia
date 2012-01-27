class AddCreatorAndUpdaterToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :creator_id, :integer
    add_column :customers, :updater_id, :integer
  end
end
