class EntriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json
  respond_to :atom, :only => :index
  inherit_resources
  load_and_authorize_resource

  def index
    @entries = Entry.order('created_at DESC').page(params[:page])
    respond_with(@entries)
  end

  def create
    @entry = current_user.entries.build(params[:entry])
    create!
  end

end
