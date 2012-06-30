class Formula < ActiveRecord::Base
  validates :formula_type, :finished_good, :presence => true
  validates :formula_type, :uniqueness => { :scope => :finished_good_id }
  
  belongs_to :finished_good
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_one :resin_formula_item, :class_name => "FormulaItem", :include => [:raw_material_type], :conditions => "raw_material_types.code = 'CMR'"
  
  has_many :formula_items, :dependent => :delete_all
  
  accepts_nested_attributes_for :formula_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:raw_material_type_id].blank? && a[:raw_material_id].blank? && a[:quantity].blank?) }
  
  after_save :set_item_multipliers
  
  protected
  
    def set_item_multipliers
      resin = self.resin_formula_item
      items = self.formula_items - [resin]
      
      items.each do |item|
        item.update_attribute(:multiplier, item.quantity/resin.quantity)
      end
    end
end
