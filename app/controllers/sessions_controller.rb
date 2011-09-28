class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    render :text => request.env['omniauth.auth'].inspect
  end
end
