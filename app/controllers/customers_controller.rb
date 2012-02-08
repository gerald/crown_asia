class CustomersController < ApplicationController

  def index
    if params[:search_text].blank?
      @customers = Customer.paginate(:per_page => 20, :page => params[:page], :order => "name")
    else
      @customers = Customer.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{params[:search_text]}%"], :order => "name")
    end
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
    @customer.destroy
    flash[:notice] = "#{@customer.name} was deleted successfully"
    redirect_to customers_path
  end

end
