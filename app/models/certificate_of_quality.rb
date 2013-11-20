class CertificateOfQuality < ActiveRecord::Base

  has_many :certificate_of_quality_items
  belongs_to :finished_good_transaction
  belongs_to :finished_good
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  accepts_nested_attributes_for :certificate_of_quality_items, :allow_destroy => true
  
  validates :coq_date, :presence => true
  validates :production_date, :presence => true
  validates :bag_number, :presence => true
  validates :bag_number, :numericality => true
  
  before_create :set_creator
  before_update :set_updater
  
  protected
  
  def set_creator
    self.creator = User.current
  end
  
  def set_updater
    self.updater = User.current
  end
end
