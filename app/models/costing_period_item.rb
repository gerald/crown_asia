class CostingPeriodItem < ActiveRecord::Base
  belongs_to :costing_period
  belongs_to :raw_material
  
  validates :raw_material, :presence => true
  # validates :quote, :fg, :presence => true
  validates :quote, :fg, :numericality => true, :allow_nil => true, :allow_blank => true
  
  before_save :set_quote_and_fg
  
  protected
  
    def set_quote_and_fg
      self.quote = nil if self.quote.blank?
      self.fg = nil if self.fg.blank?
    end
end
