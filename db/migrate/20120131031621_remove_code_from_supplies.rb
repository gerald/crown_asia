class RemoveCodeFromSupplies < ActiveRecord::Migration
  def up
    remove_column :supplies, :code
  end

  def down
    add_column :supplies, :code, :string
  end
end
