class CustomersController < ApplicationController

  def index
    @customers = Customer.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(params[:customer])
    
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
