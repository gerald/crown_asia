class RawMaterialTransactionItem < ActiveRecord::Base
  belongs_to :raw_material_transaction
  
  validates :quantity, :lot_number, :presence => true
  validates :quantity, :numericality => true
  
  acts_as_paranoid
  
  # acts_as_audited
  
end
