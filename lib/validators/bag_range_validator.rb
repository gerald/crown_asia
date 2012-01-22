class BagRangeValidator < ActiveModel::Validator  
  def validate(record)  
    record.errors.add :base, "End bag number cannot be greater than start bag number" if record.transaction_type == "add" && record.end_bag_number < record.start_bag_number
    record.errors.add :base, "Current range will use bag numbers that have already been taken" if record.transaction_type == "add" && Bag.exists?(["bag_number >= ? AND bag_number <= ?", record.start_bag_number, record.end_bag_number])
  end  
end  