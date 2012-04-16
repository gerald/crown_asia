class AddLotNumberToBags < ActiveRecord::Migration
  def change
    add_column :bags, :lot_number, :string
  end
end
