class CostingPeriod < ActiveRecord::Base
  has_many :costing_period_items, :order => "raw_material_id"
  
  validates :costing_date, :uniqueness => true
  validates :manufacturing_quote, :manufacturing_fg, :forex_quote, :forex_fg, :numericality => true, :allow_nil => true, :allow_blank => true
  
  accepts_nested_attributes_for :costing_period_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:raw_material_id].blank? && a[:quote].blank? && a[:fg].blank?) }
end