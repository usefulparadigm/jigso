class EntriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json
  inherit_resources
  load_and_authorize_resource

  def index
    @entries = Entry.order('created_at DESC').page(params[:page])
    respond_with(@entries)
  end
  
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user
    create!
  end

end
