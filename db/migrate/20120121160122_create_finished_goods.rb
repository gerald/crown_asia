class CreateFinishedGoods < ActiveRecord::Migration
  def change
    create_table :finished_goods do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :unit_of_measure_id
      t.integer :customer_id
      t.boolean :local
      t.text :comments
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
