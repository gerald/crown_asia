class CertificateOfQualitiesController < ApplicationController

  def search
    authorize! :create, CertificateOfQuality
    
    @finished_good = FinishedGood.find(params[:finished_good_id])
    
    if request.post? && !params[:lot_number].blank?
      @lot_number = params[:lot_number]
      @fg_transaction_item = FinishedGoodTransactionItem.includes(:finished_good_transaction).where("lot_number = ? AND finished_good_transactions.finished_good_id = ?", params[:lot_number], @finished_good.id).first
      
      @coq = CertificateOfQuality.new
      @coq.lot_number = params[:lot_number]
      @coq.finished_good_transaction_id = @fg_transaction_item.finished_good_transaction_id if @fg_transaction_item
      @coq.finished_good = @finished_good
      
      @coqs = CertificateOfQuality.where("finished_good_id = ? AND lot_number = ?", @finished_good.try(:id), @lot_number)
      
      CoqProperty.where("parent_id IS NULL").all.each do |coq_property|
        @coq.certificate_of_quality_items.build(:coq_property => coq_property)
        
        unless coq_property.children.empty?
          coq_property.children.each do |child|
            @coq.certificate_of_quality_items.build(:coq_property => child)
          end
        end
      end
    end
  end
  
  def create
    authorize! :create, CertificateOfQuality
    
    @coq = CertificateOfQuality.new(params[:certificate_of_quality])
    
    @finished_good = FinishedGood.find(params[:finished_good_id])
    @lot_number = @coq.lot_number
    
    if @coq.save
      flash[:notice] = "COQ added for #{@finished_good.name}"
      redirect_to finished_goods_path
    else
      render :action => "search"
    end
  end
  
  def edit
    authorize! :update, CertificateOfQuality
    
    @coq = CertificateOfQuality.find(params[:id])
  end
  
  def update
    authorize! :update, CertificateOfQuality
    
    @coq = CertificateOfQuality.find(params[:id])
    
    if @coq.update_attributes(params[:certificate_of_quality])
      flash[:notice] = "COQ was updated successfully"
      redirect_to finished_goods_path
    else
      render :action => "edit"
    end
  end
end
