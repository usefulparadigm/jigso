class Api::V1::EntriesController < Api::V1::BaseController

  def index
    respond_with(current_user.entries.all)
  end

end