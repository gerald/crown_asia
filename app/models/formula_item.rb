class FormulaItem < ActiveRecord::Base
  belongs_to :formula
  belongs_to :raw_material_type
  belongs_to :raw_material
  
  validates :quantity, :raw_material_type, :raw_material, :presence => true
  validates :quantity, :numericality => true
  
  validate :resin_quantity
  
  def resin_quantity
    errors.add(:quantity, "must be divisible by 25 for resin.") if self.raw_material_type.code == "CMR" && self.quantity && self.quantity % 25 != 0
  end
end
