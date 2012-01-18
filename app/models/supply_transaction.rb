class SupplyTransaction < ActiveRecord::Base

  belongs_to :supply
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :issued_user, :class_name => "Department"
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates_presence_of :transaction_date, :quantity
  
  validates_presence_of :rr_number, :pre_number, :supplier_name, :unit_price, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates_format_of :rr_number, :pre_number, :with => /[0-9]+/, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates_numericality_of :unit_price, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates_presence_of :mirs_number, :issued_department, :issued_user, :usage, :lot_number, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates_presence_of :mirs_number, :with => /[0-9]+/, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validates_numericality_of :quantity
  
  acts_as_paranoid
end
