class CertificateOfQualityItem < ActiveRecord::Base

  belongs_to :certificate_of_quality
  
  validates :result, :presence => true
end
