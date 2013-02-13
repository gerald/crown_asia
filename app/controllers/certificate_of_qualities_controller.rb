class CertificateOfQualitiesController < ApplicationController

  def search
    @finished_good = FinishedGood.find(params[:finished_good_id])
    
    if request.post? && !params[:lot_number].blank?
      @lot_number = params[:lot_number]
    end
  end

end
