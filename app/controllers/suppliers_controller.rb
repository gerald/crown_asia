class SuppliersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:supplier_search_text] = params[:search_text] if !params[:search_text].nil?
    @suppliers = Supplier.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{session[:supplier_search_text]}%"], :order => "name")
  end
  
  def new
    @supplier = Supplier.new
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    @supplier.creator = current_user
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
    @supplier.updater = current_user
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "#{@supplier.name} was updated successfully"
      redirect_to suppliers_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @supplier = Supplier.find(params[:id])
    if @supplier.destroy
      flash[:notice] = "#{@supplier.name} was deleted successfully"
    else
      flash[:error] = "#{@supplier.name} was not deleted successfully"
    end
    redirect_to suppliers_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Supplier
    end
    
    def authorize_create
      authorize! :create, Supplier
    end
    
    def authorize_update
      authorize! :update, Supplier
    end
    
    def authorize_delete
      authorize! :delete, Supplier
    end

end
