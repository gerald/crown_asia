class CreateFormulas < ActiveRecord::Migration
  def change
    create_table :formulas do |t|
      t.string :formula_type
      t.boolean :finished_good_local, :default => true
      t.integer :finished_good_id
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end
end
