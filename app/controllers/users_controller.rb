class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @user = User.find(params[:id])
  end

  def update
    # raise params.inspect
    current_user.update_attributes(params[:user])
    redirect_to :back
  end

end
