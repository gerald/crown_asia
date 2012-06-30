class MixersController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:mixer_search_text]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    session[:search][:mixer_search_text] = params[:search_text] if !params[:search_text].nil?
    @mixers = Mixer.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{session[:search][:mixer_search_text]}%"], :order => "name")
  end
  
  def new
    @mixer = Mixer.new
  end
  
  def create
    @mixer = Mixer.new(params[:mixer])
    @mixer.creator = current_user
    if @mixer.save
      flash[:notice] = "Mixer saved successfully"
      redirect_to mixers_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @mixer = Mixer.find(params[:id])
  end
  
  def update
    @mixer = Mixer.find(params[:id])
    @mixer.updater = current_user
    if @mixer.update_attributes(params[:mixer])
      flash[:notice] = "#{@mixer.name} was updated successfully"
      redirect_to mixers_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @mixer = Mixer.find(params[:id])
    @mixer.destroy
    flash[:notice] = "#{@mixer.name} was deleted successfully"
    redirect_to mixers_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, Mixer
    end
    
    def authorize_create
      authorize! :create, Mixer
    end
    
    def authorize_update
      authorize! :update, Mixer
    end
    
    def authorize_delete
      authorize! :delete, Mixer
    end
end
