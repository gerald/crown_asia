class SupplyTransactionItem < ActiveRecord::Base
  class_attribute :transaction_type
  
  belongs_to :supply_transaction
  belongs_to :supply
  
  validates :supply, :quantity, :presence => true
  validates :quantity, :numericality => true
  validates :unit_price, :numericality => true, :if => Proc.new { |t| t.transaction_type == "add" }
  
  acts_as_paranoid
end
