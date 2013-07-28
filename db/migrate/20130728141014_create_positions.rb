class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.boolean :active, :default => false
      t.timestamps
    end
  end
end
