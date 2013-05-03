class CreateCertificateOfQualities < ActiveRecord::Migration
  def change
    create_table :certificate_of_qualities do |t|
      t.string :lot_number
      t.integer :finished_good_transaction_id
      t.date :coq_date
      t.date :production_date
      t.integer :bag_number
      t.timestamps
    end
  end
end
