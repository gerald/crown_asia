class CostingPeriodItem < ActiveRecord::Base
  belongs_to :costing_period
  belongs_to :raw_material
  
  validates :raw_material, :presence => true
  validates :quote, :fg, :presence => true
  validates :quote, :fg, :numericality => true
end
