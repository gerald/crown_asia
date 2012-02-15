class BagsController < ApplicationController

  def return
    authorize! :return, Bag
    
    if params[:lot_number].blank?
      @bags = Bag.paginate(:per_page => 20, :page => params[:page], :conditions => ["removing_transaction_id IS NOT NULL"])
    else
      @bags = Bag.paginate(:include => [:removing_transaction], :per_page => 20, :page => params[:page], :conditions => ["finished_good_transactions.lot_number = ? AND removing_transaction_id IS NOT NULL", params[:lot_number]])
    end
    
    if request.post?
      @returned_bags = Bag.all(:conditions => ["id IN (?)", params[:bag_ids]])
      @returned_bags.each do |bag|
        bag.return
      end
      flash[:notice] = "Bags have been returned."
    end
  end

end
