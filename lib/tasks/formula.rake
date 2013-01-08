namespace :formula do
  desc 'Update multipliers'
  task :update_multipliers => :environment do
    FormulaItem.where("multiplier IS NOT NULL").all.each do |fi|
      rm_fi = FormulaItem.where("multiplier IS NULL AND formula_id = ?", fi.formula_id).first
      next if rm_fi.nil?
      fi.update_attribute(:multiplier, fi.quantity/rm_fi.quantity)
    end
  end
  
  desc 'Remove space from issued formulas lot number'
  task :fix_lot_numbers => :environment do
    IssuedFormula.where("lot_number LIKE ?", "% %").all.each{|f| f.update_attribute(:lot_number, f.lot_number.gsub(" ", ""))}
  end
end
