class CoqPropertiesController < ApplicationController 
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    @coq_properties = CoqProperty.where("parent_id IS NULL").order("position").paginate(:per_page => 20, :page => params[:page])
  end
  
  def new
    @coq_property = CoqProperty.new
  end
  
  def create
    @coq_property = CoqProperty.new(params[:coq_property])
    if @coq_property.save
      flash[:notice] = "Property saved successfully"
      redirect_to coq_properties_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @coq_property = CoqProperty.find(params[:id])
  end
  
  def update
    @coq_property = CoqProperty.find(params[:id])
    if @coq_property.update_attributes(params[:coq_property])
      flash[:notice] = "Property was updated successfully"
      redirect_to coq_properties_path
    else
      render :action => "edit"
    end
  end
  
  # def destroy
    # @coq_property = CoqProperty.find(params[:id])
    # @coq_property.destroy
    # flash[:notice] = "Property was deleted successfully"
    # redirect_to coq_properties_path
  # end
  
  protected
  
    def authorize_view
      authorize! :view, CoqProperty
    end
    
    def authorize_create
      authorize! :create, CoqProperty
    end
    
    def authorize_update
      authorize! :update, CoqProperty
    end
    
    # def authorize_delete
      # authorize! :delete, CoqProperty
    # end
end
