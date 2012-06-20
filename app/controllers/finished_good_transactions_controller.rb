class FinishedGoodTransactionsController < ApplicationController
  before_filter :authorize_create, :only => [:new, :create]
  
  def new
    @finished_good = FinishedGood.find(params[:finished_good_id])
    @finished_good_transaction = FinishedGoodTransaction.new
    @finished_good_transaction.finished_good = @finished_good
    @finished_good_transaction.transaction_type = params[:transaction_type]
    @finished_good_transaction.transaction_date = Date.today
    @finished_good_transaction.quantity_per_bag = "25" if params[:transaction_type] == "add"
    
    3.times {@finished_good_transaction.finished_good_transaction_items.build(:transaction_type => params[:transaction_type])}
    
    if params[:transaction_type] == "add" || params[:transaction_type] == "return"
      @finished_good_transaction.finished_good_transaction_items.build(:underpack => true, :transaction_type => params[:transaction_type])
    else
      3.times {@finished_good_transaction.finished_good_transaction_items.build(:transaction_type => params[:transaction_type], :underpack => true)}
    end
  end
  
  def create
    @finished_good_transaction = FinishedGoodTransaction.new(params[:finished_good_transaction])
    @finished_good_transaction.creator = current_user
    if @finished_good_transaction.save
      flash[:notice] = "Transaction added for #{@finished_good_transaction.finished_good.name}"
      redirect_to finished_goods_path
    else
      @finished_good = @finished_good_transaction.finished_good
      render :action => "new"
    end
  end
  
  # def edit
    # @finished_good_transaction = FinishedGoodTransaction.find(params[:id])
    # @finished_good = @finished_good_transaction.finished_good
  # end
  
  # def update
    # @finished_good_transaction = FinishedGoodTransaction.find(params[:id])
    # @finished_good_transaction.updater = current_user
    # if @finished_good_transaction.update_attributes(params[:finished_good_transaction])
      # flash[:notice] = "Transaction updated for #{@finished_good_transaction.finished_good.name}"
      # redirect_to transactions_finished_good_path(@finished_good_transaction.finished_good)
    # else
      # @finished_good = @finished_good_transaction.finished_good
      # render :action => "edit"
    # end
  # end
  
  # def destroy
    # @finished_good_transaction = FinishedGoodTransaction.find(params[:id])
    # @finished_good_transaction.destroy
    # flash[:notice] = "Transaction was deleted successfully"
    # redirect_to transactions_finished_good_path(@finished_good_transaction.finished_good)
  # end
  
  def update_sender
    @reference_type = params[:reference_type]
  end
  
  def update_bags
    @finished_good = FinishedGood.find(params[:finished_good_id])
    if params[:lot_number].blank?
      @bags = []
    else
      @bags = Bag.all(:conditions => ["(lot_number = ? OR lot_number IS NULL) AND bags.finished_good_id = ? AND removing_transaction_id IS NULL", params[:lot_number], @finished_good.id], :order => "bag_number")
    end
  end
  
  def update_issued
    @issue_type = params[:issue_type]
    @finished_good = FinishedGood.find(params[:finished_good_id])
  end
  
  def update_underpack
    @lot_number = params[:lot_number]
    @finished_good = FinishedGood.find(params[:finished_good_id])
    @index = params[:index]
    if @lot_number == "0"
      @underpack_bags = Bag.all(:conditions => ["bag_number = 0 AND removing_transaction_id IS NULL AND finished_good_id = ?", @finished_good.id])
    else
      @underpack_bags = []
    end
  end
  
  protected
  
    def authorize_create
      authorize! :create, FinishedGoodTransaction
    end
    
end
