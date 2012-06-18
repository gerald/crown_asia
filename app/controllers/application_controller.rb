class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  def clear_search_session(excluded_keys)
    session[:search] = {} if session[:search].nil?
    session[:search].each_pair do |key, value|
      next if excluded_keys.include?(key)
      session[:search][key] = ""
    end
  end
end
