class CreateRawMaterialTypes < ActiveRecord::Migration
  def change
    create_table :raw_material_types do |t|
      t.string :name
      t.string :code
      t.text :description
      t.timestamps
    end
  end
end
