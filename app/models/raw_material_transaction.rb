class RawMaterialTransaction < ActiveRecord::Base

  belongs_to :raw_material
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :sender, :polymorphic => true
  
  validates_presence_of :transaction_date, :quantity, :lot_number
  validates_presence_of :mirs_number, :issued_department, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates_presence_of :reference_type, :reference_number, :po_number, :sender, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates_numericality_of :quantity
  
  acts_as_paranoid

end
