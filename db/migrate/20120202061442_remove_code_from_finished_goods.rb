class RemoveCodeFromFinishedGoods < ActiveRecord::Migration
  def up
    remove_column :finished_goods, :code
  end

  def down
    add_column :finished_goods, :code, :string
  end
end
