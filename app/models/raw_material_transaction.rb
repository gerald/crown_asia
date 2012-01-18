class RawMaterialTransaction < ActiveRecord::Base

  belongs_to :raw_material
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :sender, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates_presence_of :transaction_date, :quantity, :lot_number
  validates_presence_of :reference_type, :reference_number, :po_number, :sender, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates_format_of :reference_number, :po_number, :with => /[0-9]+/, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates_presence_of :mirs_number, :issued_department, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates_format_of :mirs_number, :with => /[0-9]+/, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates_numericality_of :quantity
  
  acts_as_paranoid

end
