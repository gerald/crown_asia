class Supplier < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :raw_materials
  has_many :raw_material_transactions, :as => :sender
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  scope :active_suppliers, :conditions => {:active => true}, :order => "name"
end
