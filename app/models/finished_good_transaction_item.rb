class FinishedGoodTransactionItem < ActiveRecord::Base

  belongs_to :finished_good_transaction
  
  has_many :bags
  
  validates :quantity, :presence => true, :if => Proc.new { |item| item.underpack}
  validates :quantity, :numericality => true, :if => Proc.new { |item| item.underpack}
  
  validates :lot_number, :presence => true
  validates :start_bag_number, :end_bag_number, :presence => true, :if => Proc.new { |item| !item.underpack && item.lot_number != "0"}
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  after_save :associate_coq
  
  protected
  
    def associate_coq
      coqs = CertificateOfQuality.where("lot_number = ? AND finished_good_transaction_id IS NULL AND finished_good_id = ?", self.lot_number, self.finished_good_transaction.try(:finished_good_id))
      coqs.each do |coq|
        coq.update_attribute(:finished_good_transaction, self.finished_good_transaction)
      end
    end
  
end
