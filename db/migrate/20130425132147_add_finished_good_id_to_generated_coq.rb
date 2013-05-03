class AddFinishedGoodIdToGeneratedCoq < ActiveRecord::Migration
  def change
    add_column :generated_certificate_of_qualities, :finished_good_id, :integer
  end
end
