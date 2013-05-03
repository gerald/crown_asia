class CreateCertificateOfQualityItems < ActiveRecord::Migration
  def change
    create_table :certificate_of_quality_items do |t|
      t.integer :certificate_of_quality_id
      t.integer :coq_property_id
      t.string :result
      t.timestamps
    end
  end
end
