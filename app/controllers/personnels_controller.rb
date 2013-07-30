class PersonnelsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:last_name, :first_name, :position]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:search][:last_name] = params[:last_name] if !params[:last_name].nil?
    session[:search][:first_name] = params[:first_name] if !params[:first_name].nil?
    session[:search][:position] = params[:position] if !params[:position].nil?
    
    @personnels = Personnel.paginate(:per_page => 20, :page => params[:page])
    @personnels = @personnels.where("last_name LIKE ?", "%#{session[:search][:last_name]}%") unless session[:search][:last_name].blank?
    @personnels = @personnels.where("first_name LIKE ?", "%#{session[:search][:first_name]}%") unless session[:search][:first_name].blank?
    @personnels = @personnels.where("position_id = ?", session[:search][:position]) unless session[:search][:position].blank?
    @personnels = @personnels.order("first_name, last_name")
  end
  
  def new
    @personnel = Personnel.new
  end
  
  def create
    @personnel = Personnel.new(params[:personnel])
    if @personnel.save
      flash[:notice] = "Personnel saved successfully"
      redirect_to personnels_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @personnel = Personnel.find(params[:id])
  end
  
  def update
    @personnel = Personnel.find(params[:id])
    if @personnel.update_attributes(params[:personnel])
      flash[:notice] = "#{@personnel.name} was updated successfully"
      redirect_to personnels_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @personnel = Personnel.find(params[:id])
    @personnel.destroy
    flash[:notice] = "#{@personnel.name} was deleted successfully"
    redirect_to personnels_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Personnel
    end
    
    def authorize_create
      authorize! :create, Personnel
    end
    
    def authorize_update
      authorize! :update, Personnel
    end
    
    def authorize_delete
      authorize! :delete, Personnel
    end
  
end
