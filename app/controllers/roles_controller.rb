class RolesController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    @roles = Role.paginate(:per_page => 20, :page => params[:page]).order("name")
    @roles = @roles.where("name LIKE ?", "%#{params[:search_text]}%") unless params[:search_text].blank?
  end
  
  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:notice] = "Role saved successfully"
      redirect_to roles_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = "#{@role.name} was updated successfully"
      redirect_to roles_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    flash[:notice] = "#{@role.name} was deleted successfully"
    redirect_to roles_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Role
    end
    
    def authorize_create
      authorize! :create, Role
    end
    
    def authorize_update
      authorize! :update, Role
    end
    
    def authorize_delete
      authorize! :delete, Role
    end
    
end
