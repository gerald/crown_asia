module FinishedGoodTransactionsHelper

  def lot_number_fg_options(finished_good)
    FinishedGoodTransactionItem.all(:include => [:finished_good_transaction, :bags], :conditions => ["finished_good_transactions.finished_good_id = ? AND finished_good_transaction_items.lot_number IS NOT NULL AND bags.removing_transaction_id IS NULL AND bags.id IS NOT NULL", finished_good.id]).collect{|f| [f.lot_number, f.lot_number]}.uniq
  end
  
  def quantity_per_bag_options
    [["25", "25"], ["500", "500"], ["800", "800"]]
  end
end
