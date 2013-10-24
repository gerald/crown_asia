class DeliverySchedulesController < ApplicationController
  before_filter :authorize_view, :only => [:index]
  before_filter(:only => [:index]) { |c| c.clear_search_session([:delivery_date]) }
  before_filter :authorize_create, :only => [:new, :create]
  before_filter :authorize_update, :only => [:edit, :update]
  before_filter :authorize_cancel, :only => [:cancel]
  
  def index
    session[:search][:delivery_date] = params[:delivery_date] if !params[:delivery_date].nil?
    
    @delivery_schedules = DeliverySchedule.paginate(:per_page => 20, :page => params[:page]).order("control_number DESC")
    
    if !session[:search][:delivery_date].blank?
      @delivery_schedules = @delivery_schedules.where("delivery_date >= ? AND delivery_date <= ?", Date.parse(session[:search][:delivery_date]), Date.parse(session[:search][:delivery_date]) + 1.day)
    end
  end
  
  def new
    @delivery_schedule = DeliverySchedule.new
    @delivery_schedule.delivery_date = Date.today
    10.times {@delivery_schedule.delivery_schedule_items.build}
  end
  
  def create
    @delivery_schedule = DeliverySchedule.new(params[:delivery_schedule])
    if @delivery_schedule.save
      flash[:notice] = "Delivery has been scheduled"
      redirect_to delivery_schedules_path
    else
      (10 - @delivery_schedule.delivery_schedule_items.count).times {@delivery_schedule.delivery_schedule_items.build}
      render :action => "new"
    end
  end
  
  def edit
    @delivery_schedule = DeliverySchedule.find(params[:id])
    (10 - @delivery_schedule.delivery_schedule_items.count).times {@delivery_schedule.delivery_schedule_items.build}
  end
  
  def update
    @delivery_schedule = DeliverySchedule.find(params[:id])
    if @delivery_schedule.update_attributes(params[:delivery_schedule])
      flash[:notice] = "Delivery has been updated"
      redirect_to delivery_schedules_path
    else
      (10 - @delivery_schedule.delivery_schedule_items.count).times {@delivery_schedule.delivery_schedule_items.build}
      render :action => "edit"
    end
  end
  
  def cancel
    @delivery_schedule = DeliverySchedule.find(params[:id])
  end
  
  def cancel_schedule
    @delivery_schedule = DeliverySchedule.find(params[:id])
    @delivery_schedule.attributes = params[:delivery_schedule]
    @delivery_schedule.canceled = true
    
    if @delivery_schedule.save
      flash[:notice] = "Delivery has been scheduled"
      redirect_to delivery_schedules_path
    else
      render :action => "cancel"
    end
  end
  
  def update_item_selection
    @index = params[:index]
    @item_type = params[:item_type]
    @item_options = Object.const_get(@item_type).where("active = 1").order("name").collect{|f| [f.name, f.id]}
  end
  
  protected
  
    def authorize_view
      authorize! :view, DeliverySchedule
    end
    
    def authorize_create
      authorize! :create, DeliverySchedule
    end
    
    def authorize_update
      authorize! :update, DeliverySchedule
    end
    
    def authorize_cancel
      authorize! :cancel, DeliverySchedule
    end
  
end
