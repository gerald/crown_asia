class CostingPeriodsController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_delete, :only => [:destroy]
  
  def index
    @costing_periods = CostingPeriod.order("costing_date DESC").paginate(:per_page => 20, :page => params[:page])
  end
  
  def new
    @costing_period = CostingPeriod.new
    RawMaterial.where("costing = 1").all.each do |rm|
      @costing_period.costing_period_items.build(:raw_material => rm)
    end
  end
  
  def create
    @costing_period = CostingPeriod.new(params[:costing_period])
    if @costing_period.save
      flash[:notice] = "Costing Period saved successfully"
      redirect_to costing_periods_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @costing_period = CostingPeriod.find(params[:id])
    RawMaterial.where("costing = 1 AND id NOT IN(?)", @costing_period.costing_period_items.collect{|c| c.raw_material_id}).all.each do |rm|
      @costing_period.costing_period_items.build(:raw_material => rm)
    end
  end
  
  def update
    @costing_period = CostingPeriod.find(params[:id])
    if @costing_period.update_attributes(params[:costing_period])
      flash[:notice] = "Costing Period was updated successfully"
      redirect_to costing_periods_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @costing_period = CostingPeriod.find(params[:id])
    @costing_period.destroy
    flash[:notice] = "Costing Period was deleted successfully"
    redirect_to costing_periods_path
  end
  
  protected
  
    def authorize_view
      authorize! :view, CostingPeriod
    end
    
    def authorize_create
      authorize! :create, CostingPeriod
    end
    
    def authorize_update
      authorize! :update, CostingPeriod
    end
    
    def authorize_delete
      authorize! :delete, CostingPeriod
    end
    
    def authorize_transactions
      authorize! :transactions, CostingPeriod
    end
end
