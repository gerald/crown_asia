class BagRangeValidator < ActiveModel::Validator  
  def validate(record)  
    record.errors.add(:base, "End bag number cannot be greater than start bag number") if !record.underpack && record.end_bag_number < record.start_bag_number
    record.errors.add(:base, "Current range will use bag numbers that have already been taken") if record.transaction_type == "add" && !record.underpack && Bag.count(:include => [:finished_good_transaction_item], :conditions => ["bag_number >= ? AND bag_number <= ? AND finished_good_transaction_items.lot_number = ?", record.start_bag_number, record.end_bag_number, record.lot_number]) > 0
    record.errors.add(:base, "Current range will use bag numbers that have already been released") if record.transaction_type == "sub" && Bag.count(:include => [:finished_good_transaction_item], :conditions => ["removing_transaction_id IS NOT NULL AND bag_number >= ? AND bag_number <= ? AND finished_good_transaction_items.lot_number = ?", record.start_bag_number, record.end_bag_number, record.lot_number]) > 0
    record.errors.add(:base, "Current range will use bag numbers that don't exist") if record.transaction_type == "sub" && record.end_bag_number > record.start_bag_number && Bag.count(:include => [:finished_good_transaction_item], :conditions => ["bag_number >= ? AND bag_number <= ? AND finished_good_transaction_items.lot_number = ?", record.start_bag_number, record.end_bag_number, record.lot_number]) != (record.end_bag_number - record.start_bag_number) + 1
  end  
end  
