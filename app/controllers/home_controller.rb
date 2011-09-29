class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = current_user.recent_activities.limit(10)
  end

end
