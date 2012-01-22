class UnitOfMeasure < ActiveRecord::Base
  
  has_many :raw_materials
  has_many :supplies
  
  validates :name, :code, :presence => true

end
