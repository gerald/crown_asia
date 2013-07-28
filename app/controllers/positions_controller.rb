class PositionsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:position_name]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:search][:position_name] = params[:position_name] if !params[:position_name].nil?
    
    @positions = Position.paginate(:per_page => 20, :page => params[:page])
    @positions = @positions.where("name LIKE ?", "%#{session[:search][:position_name]}%") unless session[:search][:position_name].blank?
    @positions = @positions.order("name")
  end
  
  def new
    @position = Position.new
  end
  
  def create
    @position = Position.new(params[:position])
    if @position.save
      flash[:notice] = "Position saved successfully"
      redirect_to positions_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @position = Position.find(params[:id])
  end
  
  def update
    @position = Position.find(params[:id])
    if @position.update_attributes(params[:position])
      flash[:notice] = "#{@position.name} was updated successfully"
      redirect_to positions_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    flash[:notice] = "#{@position.name} was deleted successfully"
    redirect_to positions_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Position
    end
    
    def authorize_create
      authorize! :create, Position
    end
    
    def authorize_update
      authorize! :update, Position
    end
    
    def authorize_delete
      authorize! :delete, Position
    end
  
end
