class CreateMixers < ActiveRecord::Migration
  def change
    create_table :mixers do |t|
      t.string :name
      t.string :brand
      t.boolean :active, :default => true
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end
end
