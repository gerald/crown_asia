class UnitOfMeasuresController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    if params[:search_text].blank?
      @unit_of_measures = UnitOfMeasure.paginate(:per_page => 20, :page => params[:page], :order => "code")
    else
      @unit_of_measures = UnitOfMeasure.paginate(:per_page => 20, :page => params[:page], :conditions => ["code LIKE ?", "%#{params[:search_text]}%"], :order => "code")
    end
  end
  
  def new
    @unit_of_measure = UnitOfMeasure.new
  end
  
  def create
    @unit_of_measure = UnitOfMeasure.new(params[:unit_of_measure])
    @unit_of_measure.creator = current_user
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
    @unit_of_measure.updater = current_user
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
  
  protected
  
    def authorize_view
      authorize! :view, UnitOfMeasure
    end
    
    def authorize_create
      authorize! :create, UnitOfMeasure
    end
    
    def authorize_update
      authorize! :update, UnitOfMeasure
    end
    
    def authorize_delete
      authorize! :delete, UnitOfMeasure
    end

end
