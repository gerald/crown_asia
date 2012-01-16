class UnitOfMeasuresController < ApplicationController

  def index
    @unit_of_measures = UnitOfMeasure.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @unit_of_measure = UnitOfMeasure.new
  end
  
  def create
    @unit_of_measure = UnitOfMeasure.new(params[:unit_of_measure])
    
    if @unit_of_measure.save
      flash[:notice] = "Unit of Measure saved successfully"
      redirect_to unit_of_measures_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @unit_of_measure = UnitOfMeasure.find(params[:id])
  end
  
  def update
    @unit_of_measure = UnitOfMeasure.find(params[:id])
    
    if @unit_of_measure.update_attributes(params[:unit_of_measure])
      flash[:notice] = "#{@unit_of_measure.name} was updated successfully"
      redirect_to unit_of_measures_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @unit_of_measure = UnitOfMeasure.find(params[:id])
    @unit_of_measure.destroy
    flash[:notice] = "#{@unit_of_measure.name} was deleted successfully"
    redirect_to unit_of_measures_path
  end

end
