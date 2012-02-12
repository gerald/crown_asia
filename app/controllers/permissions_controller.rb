class PermissionsController < ApplicationController

  def index
    unless current_user.has_role?("admin")
      redirect_to root_url
      return
    end

    @role = params[:role_id] ? Role.find(params[:role_id]) : Role.find_by_name("admin")
    
    if request.post?
      @role.update_attribute(:permissions, params[:permissions])
    end
  end

end
