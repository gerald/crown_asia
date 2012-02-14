class BagsController < ApplicationController

  def return
    authorize! :return, Bag
    @bags = Bag.paginate(:per_page => 20, :page => params[:page], :conditions => ["removing_transaction_id IS NOT NULL"])
    
    if request.post?
      @returned_bags = Bag.all(:conditions => ["id IN (?)", params[:bag_ids]])
      @returned_bags.each do |bag|
        bag.return
      end
      flash[:notice] = "Bags have been returned."
    end
  end

end
