class DepartmentsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    if params[:search_text].blank?
      @departments = Department.paginate(:per_page => 20, :page => params[:page], :order => "name")
    else
      @departments = Department.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ? OR code LIKE ?", "%#{params[:search_text]}%", "%#{params[:search_text]}%"], :order => "name")
    end
  end
  
  def new
    @department = Department.new
  end
  
  def create
    @department = Department.new(params[:department])
    @department.creator = current_user
    if @department.save
      flash[:notice] = "Department saved successfully"
      redirect_to departments_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @department = Department.find(params[:id])
  end
  
  def update
    @department = Department.find(params[:id])
    @department.updater = current_user
    if @department.update_attributes(params[:department])
      flash[:notice] = "#{@department.name} was updated successfully"
      redirect_to departments_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    flash[:notice] = "#{@department.name} was deleted successfully"
    redirect_to departments_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Department
    end
    
    def authorize_create
      authorize! :create, Department
    end
    
    def authorize_update
      authorize! :update, Department
    end
    
    def authorize_delete
      authorize! :delete, Department
    end
    
end
