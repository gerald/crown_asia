class RawMaterialsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  before_filter :authorize_transactions, :only => [:transactions]
  
  def index
    session[:rm_code] = params[:search_text] if !params[:search_text].nil?
    session[:rm_type] = params[:type_text] if !params[:type_text].nil?
    
    if session[:rm_type].blank?
      @raw_materials = RawMaterial.paginate(:per_page => 20, :page => params[:page], :conditions => ["code LIKE ?", "%#{session[:rm_code]}%"], :order => "name")
    else
      @raw_materials = RawMaterial.paginate(:per_page => 20, :page => params[:page], :conditions => ["code LIKE ? AND raw_material_type_id = ?", "%#{session[:rm_code]}%", session[:rm_type]], :order => "name")
    end
  end
  
  def new
    @raw_material = RawMaterial.new
  end
  
  def create
    @raw_material = RawMaterial.new(params[:raw_material])
    @raw_material.creator = current_user
    if @raw_material.save
      flash[:notice] = "Raw Material saved successfully"
      redirect_to raw_materials_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @raw_material = RawMaterial.find(params[:id])
  end
  
  def update
    @raw_material = RawMaterial.find(params[:id])
    @raw_material.updater = current_user
    if @raw_material.update_attributes(params[:raw_material])
      flash[:notice] = "#{@raw_material.name} was updated successfully"
      redirect_to raw_materials_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @raw_material = RawMaterial.find(params[:id])
    @raw_material.destroy
    flash[:notice] = "#{@raw_material.name} was deleted successfully"
    redirect_to raw_materials_path
  end
  
  def transactions
    @raw_material = RawMaterial.find(params[:id])
    @transactions = @raw_material.raw_material_transactions.paginate(:per_page => 20, :page => params[:page], :order => "transaction_date DESC")
  end
  
  protected
  
    def authorize_view
      authorize! :view, RawMaterial
    end
    
    def authorize_create
      authorize! :create, RawMaterial
    end
    
    def authorize_update
      authorize! :update, RawMaterial
    end
    
    def authorize_delete
      authorize! :delete, RawMaterial
    end
    
    def authorize_transactions
      authorize! :transactions, RawMaterial
    end
  
end
