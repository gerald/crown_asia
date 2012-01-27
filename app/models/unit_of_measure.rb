class UnitOfMeasure < ActiveRecord::Base
  
  has_many :raw_materials
  has_many :supplies
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates :code, :presence => true
  
  def name
    self.code
  end

end
