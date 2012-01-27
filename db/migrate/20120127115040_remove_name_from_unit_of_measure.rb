class RemoveNameFromUnitOfMeasure < ActiveRecord::Migration
  def up
    remove_column :unit_of_measures, :name
  end

  def down
    add_column :unit_of_measures, :name, :string
  end
end
