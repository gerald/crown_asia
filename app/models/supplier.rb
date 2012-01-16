class Supplier < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :raw_materials
  has_many :raw_material_transactions, :as => :sender
end
