class FinishedGoodsController < ApplicationController
  def index
    @finished_goods = FinishedGood.paginate(:per_page => 20, :page => params[:page], :order => "name")
  end
  
  def new
    @finished_good = FinishedGood.new
  end
  
  def create
    @finished_good = FinishedGood.new(params[:finished_good])
    
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
end
