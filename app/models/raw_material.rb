class RawMaterial < ActiveRecord::Base
  belongs_to :raw_material_type
  belongs_to :unit_of_measure
  belongs_to :supplier
  
  has_many :raw_material_transactions, :dependent => :destroy
  
  validates :name, :code, :raw_material_type, :unit_of_measure, :supplier, :presence => true
  validates :code, :uniqueness => true
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  acts_as_paranoid
  
  def quantity_on_hand
    add_quantity = RawMaterialTransactionItem.sum("quantity", :include => [:raw_material_transaction], :conditions => ["raw_material_transactions.transaction_type = 'add' AND raw_material_transactions.raw_material_id = ?", self.id])
    sub_quantity = RawMaterialTransactionItem.sum("quantity", :include => [:raw_material_transaction], :conditions => ["raw_material_transactions.transaction_type = 'sub' AND raw_material_transactions.raw_material_id = ?", self.id])
    
    add_quantity - sub_quantity
  end
  
  def last_transaction_date
    r = self.raw_material_transactions.first(:order => "transaction_date DESC")
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
