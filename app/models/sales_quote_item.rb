class SalesQuoteItem < ActiveRecord::Base
  belongs_to :sales_quote
  belongs_to :finished_good
  
  validates :finished_good, :presence => true
  validates :quote, :numericality => true, :allow_nil => true, :allow_blank => true
  
  before_save :set_quote
  
  protected
  
    def set_quote
      self.quote = nil if self.quote.blank?
    end
end
