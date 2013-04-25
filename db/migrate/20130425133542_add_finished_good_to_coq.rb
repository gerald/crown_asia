class AddFinishedGoodToCoq < ActiveRecord::Migration
  def change
    add_column :certificate_of_qualities, :finished_good_id, :integer
  end
end
