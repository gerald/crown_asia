class RawMaterialsController < ApplicationController
  
  def index
    if params[:search_text].blank?
      @raw_materials = RawMaterial.paginate(:per_page => 20, :page => params[:page], :order => "name")
    else
      @raw_materials = RawMaterial.paginate(:per_page => 20, :page => params[:page], :conditions => ["code LIKE ?", "%#{params[:search_text]}%"], :order => "name")
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
  
end
