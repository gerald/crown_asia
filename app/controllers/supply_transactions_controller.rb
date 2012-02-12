class SupplyTransactionsController < ApplicationController
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  
  def new
    @supply_transaction = SupplyTransaction.new
    @supply_transaction.transaction_type = params[:transaction_type]
    @supply_transaction.transaction_date = Date.today
    10.times{ @supply_transaction.supply_transaction_items.build(:transaction_type => params[:transaction_type]) }
  end
  
  def create
    @supply_transaction = SupplyTransaction.new(params[:supply_transaction])
    @supply_transaction.creator = current_user
    if @supply_transaction.save
      flash[:notice] = "Supply transaction was created successfully."
      redirect_to supplies_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @supply_transaction = SupplyTransaction.find(params[:id])
  end
  
  def update
    @supply_transaction = SupplyTransaction.find(params[:id])
    @supply_transaction.updater = current_user
    if @supply_transaction.update_attributes(params[:supply_transaction])
      flash[:notice] = "Supply transaction was updated successfully"
      redirect_to supplies_path
    else
      render :action => "edit"
    end
  end
  
  # def destroy
    # @supply_transaction = SupplyTransaction.find(params[:id])
    # @supply_transaction.destroy
    # flash[:notice] = "Transaction was deleted successfully"
    # redirect_to supplies_path
  # end
  
  def update_supplies
    @supply_type = params[:supply_type]
  end
  
  protected
  
    def authorize_create
      authorize! :create, SupplyTransaction
    end
    
    def authorize_update
      authorize! :update, SupplyTransaction
    end
    
end
