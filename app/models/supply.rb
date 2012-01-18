class Supply < ActiveRecord::Base

  belongs_to :unit_of_measure
  
  has_many :supply_transactions, :dependent => :destroy
  
  validates_presence_of :name, :code, :unit_of_measure, :supply_type
  
  acts_as_paranoid
  
  def quantity_on_hand
    add_quantity = self.supply_transactions.sum("quantity", :conditions => ["transaction_type = 'add'"])
    sub_quantity = self.supply_transactions.sum("quantity", :conditions => ["transaction_type = 'sub'"])
    
    add_quantity - sub_quantity
  end
  
  def last_transaction_date
    s = self.supply_transactions.first(:order => "transaction_date DESC")
    return nil if s.nil?
    return s.transaction_date
  end
  
  def last_price
    s = self.supply_transactions.first(:conditions => ["transaction_type = 'add'"], :order => "transaction_date DESC")
    return nil if s.nil?
    return s.unit_price
  end
end
