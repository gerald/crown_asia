module FinishedGoodTransactionsHelper

  def lot_number_fg_options(finished_good)
    Bag.all(:select => "DISTINCT(lot_number)", :conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.bag_number != 0", finished_good.id], :order => "bags.lot_number").collect{|b| ["#{b.lot_number}(#{available_bag_numbers(b.lot_number, finished_good)})", b.lot_number]}
  end
  
  def lot_number_return_fg_options(finished_good)
    Bag.all(:select => "DISTINCT(lot_number)", :conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND bags.removing_transaction_id IS NOT NULL AND bags.bag_number != 0", finished_good.id], :order => "bags.lot_number").collect{|b| ["#{b.lot_number}(#{available_bag_numbers(b.lot_number, finished_good, true)})", b.lot_number]}
  end
  
  def lot_number_underpack_options(finished_good)
    Bag.all(:conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.bag_number = 0 AND bags.quantity > 0", finished_good.id], :order => "bags.lot_number").collect{|b| ["#{b.lot_number}(#{b.quantity})", b.lot_number]}.uniq
  end
  
  def lot_number_return_underpack_options(finished_good)
    Bag.all(:select => "DISTINCT(lot_number)", :conditions => ["bags.finished_good_id = ? AND bags.lot_number IS NOT NULL AND (bags.removing_transaction_id IS NOT NULL OR bags.bag_number = 0)", finished_good.id], :order => "bags.lot_number").collect{|b| ["#{b.lot_number}", b.lot_number]}
  end
  
  def quantity_per_bag_options
    [["25", "25.0"], ["500", "500.0"], ["800", "800.0"]]
  end
  
  def available_bag_numbers(lot_number, finished_good, return_transaction = false)
    if return_transaction
      bag_numbers = Bag.all(:select => "bag_number", :conditions => ["bags.bag_number != 0 AND bags.finished_good_id = ? AND bags.removing_transaction_id IS NOT NULL AND bags.lot_number = ?", finished_good.id, lot_number], :order => "bag_number").collect{|b| b.bag_number}
    else
      bag_numbers = Bag.all(:select => "bag_number", :conditions => ["bags.bag_number != 0 AND bags.finished_good_id = ? AND bags.removing_transaction_id IS NULL AND bags.lot_number = ?", finished_good.id, lot_number], :order => "bag_number").collect{|b| b.bag_number}
    end
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
