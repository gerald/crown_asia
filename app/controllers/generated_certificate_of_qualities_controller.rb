class GeneratedCertificateOfQualitiesController < ApplicationController
  def search
    authorize! :create, GeneratedCertificateOfQuality
    
    @finished_good = FinishedGood.find(params[:finished_good_id])
    
    if request.post? && (!params[:lot_number_text].blank? || !params[:lot_number_select].blank?)
      if !params[:lot_number_text].blank?
        @lot_number = params[:lot_number_text]
      else
        @lot_number = params[:lot_number_select]
      end
      
      @coq = CertificateOfQuality.where("lot_number = ? AND finished_good_id = ?", @lot_number, @finished_good.id).first
      
      if @coq
        @generated_coq = GeneratedCertificateOfQuality.new
        @generated_coq.lot_number = @lot_number
        @generated_coq.finished_good = @finished_good
        
        @generated_coqs = GeneratedCertificateOfQuality.where("finished_good_id = ? AND lot_number = ?", @finished_good.try(:id), @lot_number)
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
      redirect_to search_generated_certificate_of_qualities_path(:finished_good_id => @finished_good.id)
    else
      @generated_coqs = GeneratedCertificateOfQuality.where("finished_good_id = ? AND lot_number = ?", @finished_good.try(:id), @lot_number)
      render :action => "search"
    end
  end
end
