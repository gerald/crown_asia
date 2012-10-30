class CostingPeriod < ActiveRecord::Base
<<<<<<< HEAD
  has_many :costing_period_items, :order => "raw_material_id"
  
  validates :costing_date, :uniqueness => true
  validates :manufacturing_quote, :manufacturing_fg, :forex_quote, :forex_fg, :numericality => true, :allow_nil => true, :allow_blank => true
=======
  has_many :costing_period_items
  
  validates :costing_date, :uniqueness => true
  validates :manufacturing_quote, :manufacturing_fg, :forex_quote, :forex_fg, :presence => true
  validates :manufacturing_quote, :manufacturing_fg, :forex_quote, :forex_fg, :numericality => true
>>>>>>> 46aa80ca7b839c6bb9b6afe9e9df996ae6e37420
  
  accepts_nested_attributes_for :costing_period_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:raw_material_id].blank? && a[:quote].blank? && a[:fg].blank?) }
end
