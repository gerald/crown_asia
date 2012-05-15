class RawMaterialTransactionsController < ApplicationController
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def new
    @raw_material = RawMaterial.find(params[:raw_material_id])
    @raw_material_transaction = RawMaterialTransaction.new
    @raw_material_transaction.raw_material = @raw_material
    @raw_material_transaction.transaction_type = params[:transaction_type]
    @raw_material_transaction.transaction_date = Date.today
    5.times {@raw_material_transaction.raw_material_transaction_items.build}
  end
  
  def create
    @raw_material_transaction = RawMaterialTransaction.new(params[:raw_material_transaction])
    @raw_material_transaction.creator = current_user
    if @raw_material_transaction.save
      flash[:notice] = "Transaction added for #{@raw_material_transaction.raw_material.name}"
      redirect_to raw_materials_path
    else
      @raw_material = @raw_material_transaction.raw_material
      render :action => "new"
    end
  end
  
  def edit
    @raw_material_transaction = RawMaterialTransaction.find(params[:id])
    @raw_material = @raw_material_transaction.raw_material
  end
  
  def update
    @raw_material_transaction = RawMaterialTransaction.find(params[:id])
    @raw_material_transaction.updater = current_user
    if @raw_material_transaction.update_attributes(params[:raw_material_transaction])
      flash[:notice] = "Transaction updated for #{@raw_material_transaction.raw_material.name}"
      redirect_to transactions_raw_material_path(@raw_material_transaction.raw_material)
    else
      @raw_material = @raw_material_transaction.raw_material
      render :action => "edit"
    end
  end
  
  def destroy
    @raw_material_transaction = RawMaterialTransaction.find(params[:id])
    @raw_material_transaction.destroy
    flash[:notice] = "Transaction was deleted successfully"
    redirect_to transactions_raw_material_path(@raw_material_transaction.raw_material)
  end
  
  def update_sender
    # @raw_material_transaction = RawMaterialTransaction.find(params[:raw_material_transaction_id]) if !params[:raw_material_transaction_id].blank?
    @reference_type = params[:reference_type]
    @raw_material = RawMaterial.find(params[:raw_material_id])
  end
  
  protected
  
    def authorize_create
      authorize! :create, RawMaterialTransaction
    end
    
    def authorize_update
      authorize! :update, RawMaterialTransaction
    end
    
    def authorize_delete
      authorize! :delete, RawMaterialTransaction
    end
    
end
