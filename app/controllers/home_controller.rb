class HomeController < ApplicationController
  def index
    @activities = current_user.recent_activities.limit(10)
  end

end
