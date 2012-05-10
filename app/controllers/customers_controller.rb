class CustomersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:customer_search_text] = params[:search_text] if !params[:search_text].nil?
    @customers = Customer.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{session[:customer_search_text]}%"], :order => "name")
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
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
    if @customer.destroy
      flash[:notice] = "#{@customer.name} was deleted successfully"
    else
      flash[:error] = "#{@customer.name} cannot be deleted. There might be records associated to it."
    end
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
