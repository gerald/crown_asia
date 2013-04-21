class CertificateOfQuality < ActiveRecord::Base

  has_many :certificate_of_quality_items
  belongs_to :finished_good_transaction
  
  accepts_nested_attributes_for :certificate_of_quality_items, :allow_destroy => true
  
  validates :coq_date, :presence => true
  validates :production_date, :presence => true
  validates :bag_number, :presence => true
  validates :bag_number, :numericality => true
end
