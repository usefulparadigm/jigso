class MainController < ApplicationController

  def index
    # redirect_to home_path if current_user
    @activities = TimelineEvent.limit(10)
  end

end
