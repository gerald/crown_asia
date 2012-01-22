class RawMaterialTransaction < ActiveRecord::Base

  belongs_to :raw_material
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :sender, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates :transaction_date, :quantity, :lot_number, :presence => true
  validates :reference_type, :reference_number, :po_number, :sender, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :reference_number, :po_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :mirs_number, :issued_department, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validates :quantity, :numericality => true
  
  acts_as_paranoid

end
