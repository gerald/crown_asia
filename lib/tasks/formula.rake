namespace :formula do
  desc 'Update multipliers'
  task :update_multipliers => :environment do
    FormulaItem.where("multiplier IS NOT NULL").all.each do |fi|
      rm_fi = FormulaItem.where("multiplier IS NULL AND formula_id = ?", fi.formula_id).first
      next if rm_fi.nil?
      fi.update_attribute(:multiplier, fi.quantity/rm_fi.quantity)
    end
  end
end
