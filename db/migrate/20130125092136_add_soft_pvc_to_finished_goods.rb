class AddSoftPvcToFinishedGoods < ActiveRecord::Migration
  def change
    add_column :finished_goods, :soft_pvc, :boolean, :default => false
  end
end
