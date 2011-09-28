class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

  def index
    @authentications = current_user.authentications # if current_user
  end
  
  # Create an authentication when this is called from
  # the authentication provider callback
  def create
    omniauth = request.env["omniauth.auth"] 
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    if authentication 
      flash[:notice] = t(:signed_in)
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:success)
      redirect_to authentications_url
    elsif user = create_new_omniauth_user(omniauth)
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:welcome)
      sign_in_and_redirect(:user, user)
    else
      flash[:alert] = t(:fail)
      redirect_to new_user_registration_url   
    end
  end
  
  # Destroy an authentication
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t(:successfully_destroyed_authentication)
    redirect_to authentications_url
  end
  
  private
  
  def create_new_omniauth_user(omniauth)
    user = User.new
    user.apply_omniauth(omniauth, true)
    if user.save
      user
    else
      nil
    end
  end
  
end
