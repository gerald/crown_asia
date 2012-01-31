module FinishedGoodTransactionsHelper

  def lot_number_fg_options
    FinishedGoodTransaction.all(:include => [:added_bags], :conditions => ["bags.removing_transaction_id IS NULL AND bags.id IS NOT NULL"]).collect{|f| [f.lot_number, f.lot_number]}.uniq
  end

end
