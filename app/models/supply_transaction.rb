class SupplyTransaction < ActiveRecord::Base

  belongs_to :supply
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :issued_user, :class_name => "User"
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :supply_transaction_items, :dependent => :destroy
  
  accepts_nested_attributes_for :supply_transaction_items, :allow_destroy => true, :reject_if => lambda { |a| a[:supply_id].blank? && a[:quantity].blank? && a[:unit_price].blank? }
  
  validates :transaction_date, :supply_type, :presence => true
  
  validates :rr_number, :pre_number, :supplier_name, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :rr_number, :pre_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :mirs_number, :issued_department, :issued_user, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  acts_as_paranoid
  
  acts_as_audited
  
end