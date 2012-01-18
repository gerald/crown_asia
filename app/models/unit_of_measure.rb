class UnitOfMeasure < ActiveRecord::Base
  
  has_many :raw_materials
  has_many :supplies
  
  validates_presence_of :name, :code

end
