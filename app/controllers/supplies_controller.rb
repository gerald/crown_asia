class SuppliesController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  before_filter :authorize_transactions, :only => [:transactions]
  
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
  
  protected
  
    def authorize_view
      authorize! :view, Supply
    end
    
    def authorize_create
      authorize! :create, Supply
    end
    
    def authorize_update
      authorize! :update, Supply
    end
    
    def authorize_delete
      authorize! :delete, Supply
    end
    
    def authorize_transactions
      authorize! :transactions, Supply
    end
    
end
