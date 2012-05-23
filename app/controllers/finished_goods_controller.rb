class FinishedGoodsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  before_filter :authorize_transactions, :only => [:transactions]
  
  def index
    session[:finished_good_search_text] = params[:search_text] if !params[:search_text].nil?
    @finished_goods = FinishedGood.paginate(:per_page => 20, :page => params[:page], :conditions => ["name LIKE ?", "%#{session[:finished_good_search_text]}%"], :order => "name")
  end
  
  def new
    @finished_good = FinishedGood.new
  end
  
  def create
    @finished_good = FinishedGood.new(params[:finished_good])
    @finished_good.creator = current_user
    if @finished_good.save
      flash[:notice] = "Finished Good saved successfully"
      redirect_to finished_goods_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @finished_good = FinishedGood.find(params[:id])
  end
  
  def update
    @finished_good = FinishedGood.find(params[:id])
    @finished_good.updater = current_user
    if @finished_good.update_attributes(params[:finished_good])
      flash[:notice] = "#{@finished_good.name} was updated successfully"
      redirect_to finished_goods_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @finished_good = FinishedGood.find(params[:id])
    @finished_good.destroy
    flash[:notice] = "#{@finished_good.name} was deleted successfully"
    redirect_to finished_goods_path
  end
  
  def transactions
    @finished_good = FinishedGood.find(params[:id])
    @transactions = @finished_good.finished_good_transactions.paginate(:per_page => 20, :page => params[:page], :order => "transaction_date DESC")
  end
  
  protected
  
    def authorize_view
      authorize! :view, FinishedGood
    end
    
    def authorize_create
      authorize! :create, FinishedGood
    end
    
    def authorize_update
      authorize! :update, FinishedGood
    end
    
    def authorize_delete
      authorize! :delete, FinishedGood
    end
    
    def authorize_transactions
      authorize! :transactions, FinishedGood
    end
    
end
