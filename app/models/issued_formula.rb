class IssuedFormula < ActiveRecord::Base
  belongs_to :finished_good
  belongs_to :formula
  belongs_to :mixer
  belongs_to :extruder
  
  has_many :issued_formula_items
  
  validates :resin_big_batch_quantity, :resin_small_batch_quantity, :numericality => true
  validates :big_batch_quantity, :small_batch_quantity, :numericality => true
  validates :issuance_date, :presence => true
  
  validate :resin_quantity
  
  protected
    def resin_quantity
      errors.add(:base, "Resin quantities must be divisible by 25.") if self.resin_big_batch_quantity % 25 != 0 || self.resin_small_batch_quantity % 25 != 0
    end
end
