class SupplyTransaction < ActiveRecord::Base

  belongs_to :supply
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :issued_user, :class_name => "Department"
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates :transaction_date, :quantity, :presence => true
  
  validates :rr_number, :pre_number, :supplier_name, :unit_price, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :rr_number, :pre_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :unit_price, :numericality => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :mirs_number, :issued_department, :issued_user, :usage, :lot_number, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validates :quantity, :numericality => true
  
  acts_as_paranoid
end
