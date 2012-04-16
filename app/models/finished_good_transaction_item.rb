class FinishedGoodTransactionItem < ActiveRecord::Base

  belongs_to :finished_good_transaction
  
  has_many :bags
  
  validates :quantity, :presence => true, :if => Proc.new { |item| item.underpack}
  validates :quantity, :numericality => true, :if => Proc.new { |item| item.underpack}
  
  validates :lot_number, :presence => true
  validates :start_bag_number, :end_bag_number, :presence => true, :if => Proc.new { |item| !item.underpack && item.lot_number != "0"}
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
end
