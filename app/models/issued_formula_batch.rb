class IssuedFormulaBatch < ActiveRecord::Base
  belongs_to :issued_formula
  
  validates :start_batch, :end_batch, :start_small_batch, :end_small_batch, :numericality => true, :allow_nil => true, :allow_blank => true
end
