class IssuedFormulaBatch < ActiveRecord::Base
  belongs_to :issued_formula
  
  validates :start_batch, :end_batch, :numericality => true
end
