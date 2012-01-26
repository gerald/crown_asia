class BagRangeValidator < ActiveModel::Validator  
  def validate(record)  
    record.errors.add :base, "End bag number cannot be greater than start bag number" if record.transaction_type == "add" && record.end_bag_number < record.start_bag_number
    # record.errors.add :base, "Quantity per bag cannot be greater than total quantity" if record.transaction_type == "add" && record.quantity_per_bag > record.quantity
    # record.errors.add :base, "Specified quantity and quantity per bag will not fill all bags" if record.transaction_type == "add" && (record.quantity/record.quantity_per_bag).to_i < ((record.end_bag_number - record.start_bag_number)+1)
    # record.errors.add :base, "Specified quantity and quantity per bag cannot fit in all bags" if record.transaction_type == "add" && (record.quantity/record.quantity_per_bag).to_i > ((record.end_bag_number - record.start_bag_number)+1)
    record.errors.add :base, "Current range will use bag numbers that have already been taken" if record.transaction_type == "add" && Bag.count(:include => [:adding_transaction], :conditions => ["bag_number >= ? AND bag_number <= ? AND finished_good_transactions.lot_number = ?", record.start_bag_number, record.end_bag_number, record.lot_number]) > 0
  end  
end  