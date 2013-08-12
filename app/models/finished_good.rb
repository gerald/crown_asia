class FinishedGood < ActiveRecord::Base

  belongs_to :unit_of_measure
  belongs_to :customer
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :finished_good_transactions
  has_many :bags
  has_many :formulas
  has_many :certificate_of_qualities
  has_many :generated_certificate_of_qualities
  has_many :delivery_schedule_items
  
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
  
  def last_sales_quote_date(quote_date = nil)
    c = SalesQuote.includes(:sales_quote_items)
    c = c.where("sales_quote_items.finished_good_id = ? AND sales_quote_items.quote IS NOT NULL AND sales_quote_items.quote <> ''", self.id)
    c = c.where("sales_quotes.quote_date < ?", quote_date) if quote_date
    c = c.order("quote_date").first
    return nil if c.nil?
    return c.quote_date
  end
  
  def last_sales_quote_price(quote_date = nil)
    c = SalesQuoteItem.includes(:sales_quote)
    c = c.where("sales_quote_items.finished_good_id = ? AND sales_quote_items.quote IS NOT NULL AND sales_quote_items.quote <> ''", self.id)
    c = c.where("sales_quotes.quote_date < ?", quote_date) if quote_date
    c = c.order("sales_quotes.quote_date").first
    return nil if c.nil?
    return c.quote
  end
  
  def last_lot_number_options
    l = FinishedGoodTransactionItem.select("lot_number, created_at")
    l = l.includes(:finished_good_transaction)
    l = l.where("finished_good_transactions.finished_good_id = ?", self.id)
    l = l.group("lot_number")
    l = l.limit(10)
    l = l.order("finished_good_transaction_items.created_at DESC")
    [""] + l.collect{|fg_item| fg_item.lot_number}
  end
  
  def last_coq_lot_number_options
    l = CertificateOfQuality.select("lot_number, created_at")
    l = l.where("finished_good_id = ?", self.id)
    l = l.group("lot_number")
    l = l.limit(10)
    l = l.order("created_at DESC")
    [""] + l.collect{|c| c.lot_number}
  end
  
  def valid_delivery_schedules
    ds = self.delivery_schedule_items.includes(:delivery_schedule)
    ds = ds.where("delivery_schedules.delivery_date >= ? AND delivery_schedules.canceled = 0", Date.current)
    ds
  end

end
