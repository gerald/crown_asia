class FinishedGood < ActiveRecord::Base

  belongs_to :unit_of_measure
  belongs_to :customer
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :finished_good_transactions
  has_many :bags
  has_many :formulas
  
  validates :name, :unit_of_measure, :customer, :presence => true
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  scope :active, :conditions => {:active => true}, :order => "name"
  
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
