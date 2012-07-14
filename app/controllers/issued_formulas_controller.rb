class IssuedFormulasController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:issuance_date]) }
  before_filter :authorize_create, :only => [:new, :create]
  
  def index
    session[:search][:issuance_date] = params[:issuance_date] if !params[:issuance_date].nil?
    
    if !session[:search][:issuance_date].blank?
      @issued_formulas = IssuedFormula.paginate(:per_page => 20, :page => params[:page], :conditions => ["issuance_date = ?", session[:search][:issuance_date]])
    end
  end
  
  def new
    @issued_formula = IssuedFormula.new
  end
  
  def create
    @issued_formula = IssuedFormula.new(params[:issued_formula])
    if @issued_formula.save
      flash[:notice] = "Formula has been issued"
      redirect_to issued_formulas_path
    else
      render :action => "new"
    end
  end
  
  def update_finished_good
    @local = params[:local].to_i == 1
    @finished_good_id = params[:finished_good_id]
  end
  
  def update_formula
    @finished_good = FinishedGood.find(params[:finished_good_id])
    @formulas = @finished_good.formulas
    @formula_id = params[:formula_id]
  end
  
  def update_item_list
    @formula = Formula.find(params[:formula_id])
    @items = @formula.formula_items
    @resin_big_batch_number = params[:resin_big_batch_number].to_f * params[:big_batch_quantity].to_f
    @resin_small_batch_number = params[:resin_small_batch_number].to_f * params[:small_batch_quantity].to_f
  end
  
  protected
  
    def authorize_view
      authorize! :view, IssuedFormula
    end
    
    def authorize_create
      authorize! :create, IssuedFormula
    end
  
end
