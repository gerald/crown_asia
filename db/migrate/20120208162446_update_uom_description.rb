class UpdateUomDescription < ActiveRecord::Migration
  def up
    change_column :unit_of_measures, :description, :string
  end

  def down
    change_column :unit_of_measures, :description, :text
  end
end
