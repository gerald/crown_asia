module FinishedGoodTransactionsHelper

  def lot_number_fg_options(finished_good)
    # FinishedGoodTransactionItem.all(:include => [:finished_good_transaction, :bags], :conditions => ["finished_good_transactions.finished_good_id = ? AND finished_good_transaction_items.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.id IS NOT NULL", finished_good.id]).collect{|f| ["#{f.lot_number}(#{available_bag_numbers(f.lot_number, finished_good)})", f.lot_number]}.uniq
    Bag.all(:conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.bag_number != 0", finished_good.id]).collect{|b| ["#{b.lot_number}(#{available_bag_numbers(b.lot_number, finished_good)})", b.lot_number]}.uniq
  end
  
  def lot_number_underpack_options(finished_good)
    Bag.all(:conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.bag_number = 0", finished_good.id]).collect{|b| ["#{b.lot_number}(#{b.quantity})", b.lot_number]}.uniq
  end
  
  def quantity_per_bag_options
    [["25", "25"], ["500", "500"], ["800", "800"]]
  end
  
  def available_bag_numbers(lot_number, finished_good)
    bag_numbers = Bag.all(:select => "bag_number", :include => [{:finished_good_transaction_item => :finished_good_transaction}], :conditions => ["bags.bag_number != 0 AND finished_good_transactions.finished_good_id = ? AND removing_transaction_id IS NULL AND bags.lot_number = ?", finished_good.id, lot_number], :order => "bag_number").collect{|b| b.bag_number}
    ranges = []
    current_index = 0
    start_number = nil
    previous_number = nil
    bag_numbers.each_with_index do |bag_number, index|
      start_number = bag_number if start_number.nil?
      
      if index == 0
       ranges[current_index] = "#{start_number}"
      elsif bag_number - previous_number == 1
        ranges[current_index] = "#{start_number}-#{bag_number}"
      elsif bag_number - previous_number > 1
        current_index += 1
        start_number = bag_number
        ranges[current_index] = "#{start_number}"
      end
      
      previous_number = bag_number
    end
    return ranges.join(", ")
  end
end
