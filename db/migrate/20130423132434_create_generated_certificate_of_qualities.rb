class CreateGeneratedCertificateOfQualities < ActiveRecord::Migration
  def change
    create_table :generated_certificate_of_qualities do |t|
      t.string :lot_number
      t.integer :customer_id
      t.date :delivery_date
      t.integer :start_bag
      t.integer :end_bag
      t.timestamps
    end
  end
end
