class GeneratedCertificateOfQuality < ActiveRecord::Base
  belongs_to :customer
  belongs_to :finished_good
  
  validates :delivery_date, :presence => true
  validates :start_bag, :presence => true
  validates :start_bag, :numericality => true
  validates :end_bag, :presence => true
  validates :end_bag, :numericality => true
  validates :customer, :presence => true
end
