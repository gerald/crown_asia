class IssuedFormulasController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:issuance_date_start, :issuance_date_end]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:update]
  before_filter :authorize_process, :only => [:process_formula]
  
  def index
    session[:search][:issuance_date_start] = params[:issuance_date_start] if !params[:issuance_date_start].nil?
    session[:search][:issuance_date_end] = params[:issuance_date_end] if !params[:issuance_date_end].nil?
    session[:search][:control_number] = params[:control_number] if !params[:control_number].nil?
    
    @issued_formulas = IssuedFormula.paginate(:per_page => 20, :page => params[:page])
    
    if !session[:search][:issuance_date_start].blank? && !session[:search][:issuance_date_end].blank?
      @issued_formulas = @issued_formulas.where("issuance_date >= ? AND issuance_date <= ?", session[:search][:issuance_date_start], session[:search][:issuance_date_end])
    end
    
    @issued_formulas = @issued_formulas.where("control_number = ?", session[:search][:control_number]) if !session[:search][:control_number].blank?
  end
  
  def new
    @issued_formula = IssuedFormula.new
    @issued_formula.issuance_date = Date.today
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
  
  def update
    @issued_formula = IssuedFormula.find(params[:id])
    if @issued_formula.update_attributes(params[:issued_formula])
      flash[:notice] = "Formula has been issued"
      redirect_to issued_formulas_path
    else
      @issued_formulas = IssuedFormula.paginate(:per_page => 20, :page => params[:page], :conditions => ["issuance_date = ?", session[:search][:issuance_date]])
      render :action => "index"
    end
  end
  
  def show
    @issued_formula = IssuedFormula.find(params[:id])
    @total = 0
    @big_batch_total = 0
    @small_batch_total = 0
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
    @resin_big_batch_single = params[:resin_big_batch_number].to_f
    @resin_small_batch_single = params[:resin_small_batch_number].to_f
    @resin_big_batch_number = params[:resin_big_batch_number].to_f * params[:big_batch_quantity].to_f
    @resin_small_batch_number = params[:resin_small_batch_number].to_f * params[:small_batch_quantity].to_f
    @total = 0
    @big_batch_total = 0
    @small_batch_total = 0
  end
  
  def show_formula_comment
    @formula = Formula.find(params[:formula_id])
  end
  
  def cancel
    @issued_formula = IssuedFormula.find(params[:id])
    @issued_formula.cancel!
    redirect_to issued_formulas_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, IssuedFormula
    end
    
    def authorize_create
      authorize! :create, IssuedFormula
    end
    
    def authorize_update
      authorize! :update, IssuedFormula
    end
    
    def authorize_process
      authorize! :process, IssuedFormula
    end
  
end
