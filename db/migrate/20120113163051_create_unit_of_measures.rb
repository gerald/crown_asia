class CreateUnitOfMeasures < ActiveRecord::Migration
  def change
    create_table :unit_of_measures do |t|
      t.string :name
      t.string :code
      t.text :description
      t.timestamps
    end
  end
end
