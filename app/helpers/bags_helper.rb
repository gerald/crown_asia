module BagsHelper

  def lot_number_bag_options(finished_good = nil)
    if finished_good
      FinishedGoodTransaction.all(:include => [:removed_bags], :conditions => ["finished_good_transactions.finished_good_id = ? AND bags.removing_transaction_id IS NOT NULL AND bags.id IS NOT NULL", finished_good.id]).collect{|f| [f.lot_number, f.lot_number]}.uniq
    else
      FinishedGoodTransaction.all(:include => [:removed_bags], :conditions => ["bags.removing_transaction_id IS NOT NULL AND bags.id IS NOT NULL"]).collect{|f| [f.lot_number, f.lot_number]}.uniq
    end
  end

end
