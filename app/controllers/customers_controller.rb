class CustomersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    authorize! :view, Customer
    if params[:search_text].blank?
      @customers = Customer.paginate(:per_page => 20, :page => params[:page], :order => "name")
    else
      @customers = Customer.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{params[:search_text]}%"], :order => "name")
    end
  end
  
  def new
    authorize! :create, Customer
    @customer = Customer.new
  end
  
  def create
    authorize! :create, Customer
    @customer = Customer.new(params[:customer])
    @customer.creator = current_user
    if @customer.save
      flash[:notice] = "Customer saved successfully"
      redirect_to customers_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.updater = current_user
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "#{@customer.name} was updated successfully"
      redirect_to customers_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = "#{@customer.name} was deleted successfully"
    redirect_to customers_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Customer
    end
    
    def authorize_create
      authorize! :create, Customer
    end
    
    def authorize_update
      authorize! :update, Customer
    end
    
    def authorize_delete
      authorize! :delete, Customer
    end

end
