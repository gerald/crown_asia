class Supplier < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :raw_materials
  has_many :raw_material_transactions, :as => :sender
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  before_destroy :check_raw_materials
  
  scope :active_suppliers, :conditions => {:active => true}, :order => "name"
  
  protected
  
    def check_raw_materials
      if self.raw_materials.count > 0 || self.raw_material_transactions.count > 0
        errors.add(:base, "Cannot delete the supplier because it is currently associated with a record.")
      end
      errors.blank?
    end
end
