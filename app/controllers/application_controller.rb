class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_user!

  # https://github.com/ryanb/cancan/wiki/exception-handling
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in
  def after_sign_in_path_for(resource)
      stored_location_for(resource) || home_path
  end
    
end
