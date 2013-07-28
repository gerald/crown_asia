class TrucksController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:plate_number]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:search][:plate_number] = params[:plate_number] if !params[:plate_number].nil?
    
    @trucks = Truck.paginate(:per_page => 20, :page => params[:page])
    @trucks = @trucks.where("plate_number LIKE ?", "%#{session[:search][:plate_number]}%") unless session[:search][:plate_number].blank?
    @trucks = @trucks.order("plate_number")
  end
  
  def new
    @truck = Truck.new
  end
  
  def create
    @truck = Truck.new(params[:truck])
    if @truck.save
      flash[:notice] = "Truck saved successfully"
      redirect_to trucks_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @truck = Truck.find(params[:id])
  end
  
  def update
    @truck = Truck.find(params[:id])
    if @truck.update_attributes(params[:truck])
      flash[:notice] = "#{@truck.plate_number} was updated successfully"
      redirect_to trucks_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @truck = Truck.find(params[:id])
    @truck.destroy
    flash[:notice] = "#{@truck.plate_number} was deleted successfully"
    redirect_to trucks_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Truck
    end
    
    def authorize_create
      authorize! :create, Truck
    end
    
    def authorize_update
      authorize! :update, Truck
    end
    
    def authorize_delete
      authorize! :delete, Truck
    end
  
end
