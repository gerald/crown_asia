class CreatePersonnels < ActiveRecord::Migration
  def change
    create_table :personnels do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :active, :default => false
      t.integer :position_id
      t.timestamps
    end
  end
end
