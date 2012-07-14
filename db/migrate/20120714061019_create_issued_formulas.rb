class CreateIssuedFormulas < ActiveRecord::Migration
  def change
    create_table :issued_formulas do |t|
      t.string :control_number
      t.date :issuance_date
      t.boolean :finished_good_local, :default => true
      t.integer :finished_good_id
      t.integer :formula_id
      t.integer :mixer_id
      t.integer :extruder_id
      t.float :resin_big_batch_quantity
      t.float :resin_small_batch_quantity
      t.float :big_batch_quantity
      t.float :small_batch_quantity
      t.timestamps
    end
  end
end
