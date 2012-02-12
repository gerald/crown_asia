class UsersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    @users = User.paginate(:per_page => 20, :page => params[:page], :order => "username")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User saved successfully"
      redirect_to users_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.name} was updated successfully"
      redirect_to users_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "#{@user.name} was deleted successfully"
    redirect_to users_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, User
    end
    
    def authorize_create
      authorize! :create, User
    end
    
    def authorize_update
      authorize! :update, User
    end
    
    def authorize_delete
      authorize! :delete, User
    end
end
