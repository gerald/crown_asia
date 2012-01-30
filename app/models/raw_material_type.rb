class RawMaterialType < ActiveRecord::Base
  
  has_many :raw_materials
  
  validates :code, :presence => true
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  def name
    self.code
  end
end
