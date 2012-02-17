module BagsHelper

  def lot_number_bag_options(finished_good = nil)
    if finished_good
      FinishedGoodTransactionItem.all(:include => [{:finished_good_transaction => :removed_bags}], :conditions => ["finished_good_transaction_items.transaction_type = 'sub' AND finished_good_transactions.finished_good_id = ? AND  bags.removing_transaction_id IS NOT NULL AND bags.id IS NOT NULL", finished_good.id]).collect{|f| [f.lot_number, f.lot_number]}.uniq
    else
      FinishedGoodTransactionItem.all(:include => [{:finished_good_transaction => :removed_bags}], :conditions => ["finished_good_transaction_items.transaction_type = 'sub' AND bags.removing_transaction_id IS NOT NULL AND bags.id IS NOT NULL"]).collect{|f| [f.lot_number, f.lot_number]}.uniq
    end
  end

end
