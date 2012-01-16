class UnitOfMeasure < ActiveRecord::Base
  
  has_many :raw_materials
  
  validates_presence_of :name, :code

end
