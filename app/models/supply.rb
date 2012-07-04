class Supply < ActiveRecord::Base

  belongs_to :unit_of_measure
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :supply_transaction_items, :dependent => :destroy
  
  validates :name, :unit_of_measure, :supply_type, :presence => true
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  scope :active, :conditions => {:active => true}, :order => "name"
  
  def quantity_on_hand
    add_quantity = SupplyTransactionItem.sum("quantity", :include => [:supply_transaction], :conditions => ["supply_transactions.transaction_type = 'add' AND supply_transaction_items.supply_id = ?", self.id])
    sub_quantity = SupplyTransactionItem.sum("quantity", :include => [:supply_transaction], :conditions => ["supply_transactions.transaction_type = 'sub' AND supply_transaction_items.supply_id = ?", self.id])
    
    add_quantity - sub_quantity
  end
  
  def last_transaction_date
    s = self.supply_transaction_items.first(:include => [:supply_transaction], :order => "supply_transactions.transaction_date DESC")
    return nil if s.nil?
    return s.supply_transaction.transaction_date
  end
  
  def last_price
    s = self.supply_transaction_items.first(:include => [:supply_transaction], :conditions => ["supply_transactions.transaction_type = 'add'"], :order => "supply_transactions.transaction_date DESC")
    return nil if s.nil?
    return s.unit_price
  end
end
