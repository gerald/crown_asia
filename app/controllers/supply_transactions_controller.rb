class SupplyTransactionsController < ApplicationController

  def new
    @supply = Supply.find(params[:supply_id])
    @supply_transaction = SupplyTransaction.new
    @supply_transaction.supply = @supply
    @supply_transaction.transaction_type = params[:transaction_type]
    @supply_transaction.transaction_date = Date.today
  end
  
  def create
    @supply_transaction = SupplyTransaction.new(params[:supply_transaction])
    @supply_transaction.creator = current_user
    if @supply_transaction.save
      flash[:notice] = "Transaction added for #{@supply_transaction.supply.name}"
      redirect_to supplies_path
    else
      @supply = @supply_transaction.supply
      render :action => "new"
    end
  end
  
  def edit
    @supply_transaction = SupplyTransaction.find(params[:id])
    @supply = @supply_transaction.supply
  end
  
  def update
    @supply_transaction = SupplyTransaction.find(params[:id])
    @supply_transaction.updater = current_user
    if @supply_transaction.update_attributes(params[:supply_transaction])
      flash[:notice] = "Transaction updated for #{@supply_transaction.supply.name}"
      redirect_to transactions_supply_path(@supply_transaction.supply)
    else
      @supply = @supply_transaction.supply
      render :action => "edit"
    end
  end
  
  def destroy
    @supply_transaction = SupplyTransaction.find(params[:id])
    @supply_transaction.destroy
    flash[:notice] = "Transaction was deleted successfully"
    redirect_to transactions_supply_path(@supply_transaction.supply)
  end
  
end
