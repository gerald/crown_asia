class SuppliesController < ApplicationController
  def index
    @supplies = Supply.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @supply = Supply.new
  end
  
  def create
    @supply = Supply.new(params[:supply])
    
    if @supply.save
      flash[:notice] = "Supply saved successfully"
      redirect_to supplies_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @supply = Supply.find(params[:id])
  end
  
  def update
    @supply = Supply.find(params[:id])
    
    if @supply.update_attributes(params[:supply])
      flash[:notice] = "#{@supply.name} was updated successfully"
      redirect_to supplies_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @supply = Supply.find(params[:id])
    @supply.destroy
    flash[:notice] = "#{@supply.name} was deleted successfully"
    redirect_to supplies_path
  end
  
  def transactions
    @supply = Supply.find(params[:id])
    @transactions = @supply.supply_transactions.paginate(:per_page => 20, :page => params[:page], :order => "transaction_date DESC")
  end
end
