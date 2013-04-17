class CertificateOfQualityItem < ActiveRecord::Base

  belongs_to :certificate_of_quality
  belongs_to :coq_property
  
  validates :result, :presence => true
end
