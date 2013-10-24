class RawMaterial < ActiveRecord::Base
  belongs_to :raw_material_type
  belongs_to :unit_of_measure
  belongs_to :supplier
  
  has_many :raw_material_transactions, :dependent => :destroy
  
  has_many :delivery_schedule_items, :as => :item
  
  validates :name, :code, :raw_material_type, :unit_of_measure, :supplier, :presence => true
  validates :code, :uniqueness => true
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  scope :active, :conditions => {:active => true}, :order => "name"
  
  def quantity_on_hand(lot_number = nil)
    if lot_number.nil?
      add_quantity = RawMaterialTransactionItem.includes(:raw_material_transaction).where("raw_material_transactions.transaction_type = 'add' AND raw_material_transactions.raw_material_id = ?", self.id).sum("quantity")
      sub_quantity = RawMaterialTransactionItem.includes(:raw_material_transaction).where("raw_material_transactions.transaction_type = 'sub' AND raw_material_transactions.raw_material_id = ?", self.id).sum("quantity")
    else
      add_quantity = RawMaterialTransactionItem.includes(:raw_material_transaction).where("raw_material_transactions.transaction_type = 'add' AND raw_material_transactions.raw_material_id = ? AND lot_number = ?", self.id, lot_number).sum("quantity")
      sub_quantity = RawMaterialTransactionItem.includes(:raw_material_transaction).where("raw_material_transactions.transaction_type = 'sub' AND raw_material_transactions.raw_material_id = ? AND lot_number = ?", self.id, lot_number).sum("quantity")
    end
    
    add_quantity - sub_quantity
  end
  
  def quantity_on_hand_for_formula
    total_big_batch = IssuedFormulaItem.includes({:issued_formula => :issued_formula_batches}).where("issued_formulas.canceled_big_batch = 0 AND issued_formula_batches.processed = 0 AND issued_formula_items.raw_material_id = ?", self.id).sum("big_batch_quantity")
    total_small_batch = IssuedFormulaItem.includes({:issued_formula => :issued_formula_batches}).where("issued_formulas.canceled_small_batch = 0 AND issued_formula_batches.processed = 0 AND issued_formula_items.raw_material_id = ?", self.id).sum("small_batch_quantity")
    self.quantity_on_hand - (total_big_batch + total_small_batch)
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
  
  def critical?
    return false if self.critical_quantity.nil?
    self.quantity_on_hand <= self.critical_quantity
  end
  
  def name_with_code
    "#{self.raw_material_type.code} #{self.code}: #{self.name}"
  end
  
  def last_costing_period_quote_date(costing_date = nil)
    c = CostingPeriod.includes(:costing_period_items)
    c = c.where("costing_period_items.raw_material_id = ? AND costing_period_items.quote IS NOT NULL AND costing_period_items.quote <> ''", self.id)
    c = c.where("costing_periods.costing_date < ?", costing_date) if costing_date
    c = c.order("costing_date DESC").first
    return nil if c.nil?
    return c.costing_date
  end
  
  def last_costing_period_quote(costing_date = nil)
    c = CostingPeriodItem.includes(:costing_period)
    c = c.where("costing_period_items.raw_material_id = ? AND costing_period_items.quote IS NOT NULL AND costing_period_items.quote <> ''", self.id)
    c = c.where("costing_periods.costing_date < ?", costing_date) if costing_date
    c = c.order("costing_periods.costing_date DESC").first
    return nil if c.nil?
    return c.quote
  end
  
  def last_costing_period_fg_date(costing_date = nil)
    c = CostingPeriod.includes(:costing_period_items)
    c = c.where("costing_period_items.raw_material_id = ? AND costing_period_items.fg IS NOT NULL AND costing_period_items.fg <> ''", self.id)
    c = c.where("costing_periods.costing_date < ?", costing_date) if costing_date
    c = c.order("costing_date DESC").first
    return nil if c.nil?
    return c.costing_date
  end
  
  def last_costing_period_fg(costing_date = nil)
    c = CostingPeriodItem.includes(:costing_period)
    c = c.where("costing_period_items.raw_material_id = ? AND costing_period_items.fg IS NOT NULL AND costing_period_items.fg <> ''", self.id)
    c = c.where("costing_periods.costing_date < ?", costing_date) if costing_date
    c = c.order("costing_periods.costing_date DESC").first
    return nil if c.nil?
    return c.fg
  end
end
