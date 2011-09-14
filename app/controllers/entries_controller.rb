class EntriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json
  inherit_resources
  # load_and_authorize_resource

  def index
    respond_with(@entries = Entry.order('created_at DESC').page(params[:page]))
  end

end
