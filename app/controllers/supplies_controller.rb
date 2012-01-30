class SuppliesController < ApplicationController
  def index
    if params[:search_text].blank?
      @supplies = Supply.paginate(:per_page => 20, :page => params[:page], :order => "name")
    else
      @supplies = Supply.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{params[:search_text]}%"], :order => "name")
    end
  end
  
  def new
    @supply = Supply.new
  end
  
  def create
    @supply = Supply.new(params[:supply])
    @supply.creator = current_user
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
    @supply.updater = current_user
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
    @transactions = @supply.supply_transaction_items.paginate(:per_page => 20, :page => params[:page], :include => [:supply_transaction], :order => "supply_transactions.transaction_date DESC")
  end
end
