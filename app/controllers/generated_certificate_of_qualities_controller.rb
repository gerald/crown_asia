class GeneratedCertificateOfQualitiesController < ApplicationController
  def search
    authorize! :create, GeneratedCertificateOfQuality
    
    @finished_good = FinishedGood.find(params[:finished_good_id])
    
    if request.post? && !params[:lot_number].blank?
      @lot_number = params[:lot_number]
      @coq = CertificateOfQuality.where("lot_number = ? AND finished_good_id = ?", params[:lot_number], @finished_good.id).first
      
      if @coq
        @generated_coq = GeneratedCertificateOfQuality.new
        @generated_coq.lot_number = @lot_number
        @generated_coq.finished_good = @finished_good
      else
        flash.now[:error] = "No COQ found for given lot number"
      end
    end
  end
  
  def create
    authorize! :create, GeneratedCertificateOfQuality
    
    @generated_coq = GeneratedCertificateOfQuality.new(params[:generated_certificate_of_quality])
    
    @finished_good = FinishedGood.find(params[:finished_good_id])
    @lot_number = @generated_coq.lot_number
    
    if @generated_coq.save
      flash[:notice] = "COQ Generated"
      redirect_to finished_goods_path
    else
      render :action => "search"
    end
  end
end
