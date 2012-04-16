class BagsController < ApplicationController

  def return
    authorize! :return, Bag
    
    @conditions = ["removing_transaction_id IS NOT NULL"]
    
    if !params[:lot_number].blank?
      @conditions[0] << " AND lot_number = ?"
      @conditions << params[:lot_number]
    end
    
    if !params[:finished_good_id].blank?
      @conditions[0] << " AND bags.finished_good_id = ?"
      @conditions << params[:finished_good_id]
    end
    
    if request.post?
      @returned_bags = Bag.all(:conditions => ["id IN (?)", params[:bag_ids]])
      @returned_bags.each do |bag|
        bag.return
      end
      flash[:notice] = "Bags have been returned."
    end
    
    @bags = Bag.paginate(:per_page => 20, :page => params[:page], :include => [{:removing_transaction => :finished_good_transaction_items}], :conditions => @conditions)
  end
  
  def update_lot_numbers
    @finished_good = FinishedGood.find(params[:finished_good_id]) if !params[:finished_good_id].blank?
    @lot_number = params[:lot_number]
  end

end
