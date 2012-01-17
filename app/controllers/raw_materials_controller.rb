class RawMaterialsController < ApplicationController
  
  def index
    @raw_materials = RawMaterial.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @raw_material = RawMaterial.new
  end
  
  def create
    @raw_material = RawMaterial.new(params[:raw_material])
    
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
