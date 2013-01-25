class CreateCoqProperties < ActiveRecord::Migration
  def change
    create_table :coq_properties do |t|
      t.string :name
      t.string :test_method
      t.boolean :soft, :default => false
      t.boolean :rigid, :default => false
      t.integer :position
      t.integer :parent_id
      t.timestamps
    end
  end
end
