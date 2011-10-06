class Api::V1::EntriesController < Api::V1::BaseController

  def index
    respond_with(current_user.entries.all)
  end
  
  def create
    entry = current_user.entries.create(params[:entry])
    if entry.valid?
      respond_with(entry, :location => api_v1_entry_path(entry))
    else
      respond_with(entry)
    end    
  end

end