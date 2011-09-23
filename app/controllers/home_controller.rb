class HomeController < ApplicationController
  def index
    @recent_activities = current_user.recent_activities.limit(10)
  end

end
