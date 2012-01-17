class RawMaterial < ActiveRecord::Base
  belongs_to :raw_material_type
  belongs_to :unit_of_measure
  belongs_to :supplier
  
  has_many :raw_material_transactions, :dependent => :destroy
  
  validates_presence_of :name, :code, :raw_material_type, :unit_of_measure, :supplier
  validates_uniqueness_of :code
  
  acts_as_paranoid
  
  def quantity_on_hand
    add_quantity = self.raw_material_transactions.sum("quantity", :conditions => ["transaction_type = 'add'"])
    sub_quantity = self.raw_material_transactions.sum("quantity", :conditions => ["transaction_type = 'sub'"])
    
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
