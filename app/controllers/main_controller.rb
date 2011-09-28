class MainController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    # redirect_to home_path if current_user
    @activities = TimelineEvent.limit(10)
  end

end
