class FinishedGoodTransactionItem < ActiveRecord::Base

  belongs_to :finished_good_transaction
  
  has_many :bags
  
  # validates :quantity, :presence => true
  validates :quantity, :numericality => true, :allow_blank => true, :allow_nil => true
  
  validates :lot_number, :presence => true, :if => Proc.new { |item| !item.underpack }
  validates :start_bag_number, :end_bag_number, :presence => true, :if => Proc.new { |item| !item.underpack && item.lot_number != "0"}
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  serialize :underpack_bags
  
end
