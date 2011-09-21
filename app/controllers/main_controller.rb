class MainController < ApplicationController
  skip_before_filter :authenticate_user! #, :except => [:index, :show]

  def index
    redirect_to home_path if current_user
  end

end
