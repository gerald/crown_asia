class IssuedFormulaItem < ActiveRecord::Base
  belongs_to :issued_formula
  belongs_to :raw_material
end
