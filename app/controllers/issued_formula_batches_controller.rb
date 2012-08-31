class IssuedFormulaBatchesController < ApplicationController
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def new
    @issued_formula_batch = IssuedFormulaBatch.new
    @issued_formula = IssuedFormula.find(params[:issued_formula_id])
    @issued_formula_batch.issued_formula = @issued_formula
  end
  
  def create
    @issued_formula_batch = IssuedFormulaBatch.new(params[:issued_formula_batch])
    if @issued_formula_batch.save
      flash[:notice] = "Batch saved successfully"
      redirect_to issued_formula_path(@issued_formula_batch.issued_formula)
    else
      @issued_formula = @issued_formula_batch.issued_formula
      render :action => "new"
    end
  end
  
  def edit
    @issued_formula_batch = IssuedFormulaBatch.find(params[:id])
    @issued_formula = @issued_formula_batch.issued_formula
  end
  
  def update
    @issued_formula_batch = IssuedFormulaBatch.find(params[:id])
    if @issued_formula_batch.update_attributes(params[:issued_formula_batch])
      flash[:notice] = "Batch was updated successfully"
      redirect_to issued_formula_path(@issued_formula_batch.issued_formula)
    else
      @issued_formula = @issued_formula_batch.issued_formula
      render :action => "edit"
    end
  end
  
  def destroy
    @issued_formula_batch = IssuedFormulaBatch.find(params[:id])
    @issued_formula_batch.destroy
    flash[:notice] = "Batch was deleted successfully"
    redirect_to issued_formula_path(@issued_formula_batch.issued_formula)
  end
  
  protected
  
    def authorize_view
      authorize! :view, IssuedFormulaBatch
    end
    
    def authorize_create
      authorize! :create, IssuedFormulaBatch
    end
    
    def authorize_update
      authorize! :update, IssuedFormulaBatch
    end
    
    def authorize_delete
      authorize! :delete, IssuedFormulaBatch
    end
    
    def authorize_transactions
      authorize! :transactions, IssuedFormulaBatch
    end
    
end
