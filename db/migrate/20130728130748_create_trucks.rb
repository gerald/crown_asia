class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
      t.string :plate_number
      t.text :description
      t.integer :capacity
      t.timestamps
    end
  end
end
