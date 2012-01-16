class CreateRawMaterials < ActiveRecord::Migration
  def change
    create_table :raw_materials do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :raw_material_type_id
      t.integer :unit_of_measure_id
      t.integer :supplier_id
      t.boolean :local
      t.text :comments
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
