class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  before_filter { |c| c.set_title }
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  def clear_search_session(excluded_keys = nil)
    session[:search] = {} if session[:search].nil?
    if excluded_keys
      session[:search].each_pair do |key, value|
        next if excluded_keys.include?(key)
        session[:search][key] = ""
      end
    else
      session[:search] = {}
    end
  end
  
  def set_title(custom_title = nil)
    if custom_title.blank?
      action_title = action_name
      action_title = action_title == "index" ? "" : "#{action_title.titleize} "
      controller_title = controller_name.titleize.singularize
      @title = "CIMS - #{action_title}#{controller_title}"
    else
      @title = custom_title
    end
  end
end
