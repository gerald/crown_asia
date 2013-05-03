class SalesQuotesController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    @sales_quotes = SalesQuote.order("quote_date DESC").paginate(:per_page => 20, :page => params[:page])
  end
  
  def new
    @sales_quote = SalesQuote.new
    FinishedGood.where("sales_quote = 1").all.each do |fg|
      @sales_quote.sales_quote_items.build(:finished_good => fg)
    end
  end
  
  def create
    @sales_quote = SalesQuote.new(params[:sales_quote])
    if @sales_quote.save
      flash[:notice] = "Sales Quote saved successfully"
      redirect_to sales_quotes_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @sales_quote = SalesQuote.find(params[:id])
    FinishedGood.where("sales_quote = 1 AND id NOT IN(?)", @sales_quote.sales_quote_items.collect{|c| c.finished_good_id}).all.each do |fg|
      @sales_quote.sales_quote_items.build(:finished_good => fg)
    end
  end
  
  def update
    @sales_quote = SalesQuote.find(params[:id])
    if @sales_quote.update_attributes(params[:sales_quote])
      flash[:notice] = "Sales Quote was updated successfully"
      redirect_to sales_quotes_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @sales_quote = SalesQuote.find(params[:id])
    @sales_quote.destroy
    flash[:notice] = "Sales Quote was deleted successfully"
    redirect_to sales_quotes_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, SalesQuote
    end
    
    def authorize_create
      authorize! :create, SalesQuote
    end
    
    def authorize_update
      authorize! :update, SalesQuote
    end
    
    def authorize_delete
      authorize! :delete, SalesQuote
    end
end
