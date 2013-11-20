class CertificateOfQualityItem < ActiveRecord::Base

  belongs_to :certificate_of_quality
  belongs_to :coq_property
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates :result, :presence => true, :if =>  Proc.new { |item| item.coq_property.children.empty?}
  
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
