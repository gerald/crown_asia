class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @supplier = Supplier.new
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    
    if @supplier.save
      flash[:notice] = "Supplier saved successfully"
      redirect_to suppliers_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @supplier = Supplier.find(params[:id])
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "#{@supplier.name} was updated successfully"
      redirect_to suppliers_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    flash[:notice] = "#{@supplier.name} was deleted successfully"
    redirect_to suppliers_path
  end

end
