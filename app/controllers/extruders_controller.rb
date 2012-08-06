class ExtrudersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:extruder_search_text]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:search][:extruder_search_text] = params[:search_text] if !params[:search_text].nil?
    @extruders = Extruder.paginate(:per_page => 20, :page => params[:page])
    @extruders = @extruders.where("name LIKE ?", "%#{session[:search][:extruder_search_text]}%")
    @extruders = @extruders.order("name")
  end
  
  def new
    @extruder = Extruder.new
  end
  
  def create
    @extruder = Extruder.new(params[:extruder])
    @extruder.creator = current_user
    if @extruder.save
      flash[:notice] = "Extruder saved successfully"
      redirect_to extruders_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @extruder = Extruder.find(params[:id])
  end
  
  def update
    @extruder = Extruder.find(params[:id])
    @extruder.updater = current_user
    if @extruder.update_attributes(params[:extruder])
      flash[:notice] = "#{@extruder.name} was updated successfully"
      redirect_to extruders_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @extruder = Extruder.find(params[:id])
    @extruder.destroy
    flash[:notice] = "#{@extruder.name} was deleted successfully"
    redirect_to extruders_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Extruder
    end
    
    def authorize_create
      authorize! :create, Extruder
    end
    
    def authorize_update
      authorize! :update, Extruder
    end
    
    def authorize_delete
      authorize! :delete, Extruder
    end
end
