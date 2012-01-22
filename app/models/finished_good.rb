class FinishedGood < ActiveRecord::Base

  belongs_to :unit_of_measure
  belongs_to :customer
  
  has_many :finished_good_transactions
  has_many :bags
  
  validates :name, :code, :unit_of_measure, :customer, :presence => true
  validates :code, :uniqueness => true
  
  acts_as_paranoid
  
  def quantity_on_hand
    self.bags.sum("quantity", :conditions => ["removing_transaction_id IS NULL"])
  end
  
  def last_transaction_date
    r = self.finished_good_transactions.first(:order => "transaction_date DESC")
    return nil if r.nil?
    return r.transaction_date
  end
  
  def classification
    return nil if self.last_transaction_date.nil?
    return "F" if Date.today - self.last_transaction_date < 30
    return "S" if Date.today - self.last_transaction_date >= 30 && Date.today - self.last_transaction_date < 365
    return "N" if Date.today - self.last_transaction_date >= 365
  end

end
