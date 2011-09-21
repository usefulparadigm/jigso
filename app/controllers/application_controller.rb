class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  # https://github.com/ryanb/cancan/wiki/exception-handling
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
end
