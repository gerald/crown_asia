class RawMaterialTransactionsController < ApplicationController

  def new
    @raw_material = RawMaterial.find(params[:raw_material_id])
    @raw_material_transaction = RawMaterialTransaction.new
    @raw_material_transaction.raw_material = @raw_material
    @raw_material_transaction.transaction_type = params[:transaction_type]
    @raw_material_transaction.transaction_date = Date.today
  end
  
  def create
    @raw_material_transaction = RawMaterialTransaction.new(params[:raw_material_transaction])
    if @raw_material_transaction.save
      flash[:notice] = "Transaction added for #{@raw_material_transaction.raw_material.name}"
      redirect_to raw_materials_path
    else
      @raw_material = @raw_material_transaction.raw_material
      render :action => "new"
    end
  end
  
  def update_sender
    @reference_type = params[:reference_type]
  end

end
