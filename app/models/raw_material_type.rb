class RawMaterialType < ActiveRecord::Base
  
  has_many :raw_materials
  
  validates :name, :code, :presence => true

end
