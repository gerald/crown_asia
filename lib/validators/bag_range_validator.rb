class BagRangeValidator < ActiveModel::Validator  
  def validate(record)  
    record.errors.add :base, "End bag number cannot be greater than start bag number" if !record.underpack && record.end_bag_number < record.start_bag_number
    record.errors.add :base, "Current range will use bag numbers that have already been taken" if !record.underpack && Bag.count(:include => [:finished_good_transaction_item], :conditions => ["bag_number >= ? AND bag_number <= ? AND finished_good_transaction_items.lot_number = ?", record.start_bag_number, record.end_bag_number, record.lot_number]) > 0
  end  
end  