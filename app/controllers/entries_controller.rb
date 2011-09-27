class EntriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json
  respond_to :atom, :only => :index
  inherit_resources
  load_and_authorize_resource

  def index
    # @recent_events = current_user.recent_events.limit(10)
    @entries = Entry.order('created_at DESC')
    @entries = @entries.tagged_with(params[:tag]) if params[:tag]
    @entries = @entries.page(params[:page])
    respond_with(@entries)
  end

  def new
    @entry = Entry.new(:item_id => params[:item_id])
  end  

  def create
    @entry = current_user.entries.build(params[:entry])
    @entry.keep_the_item = params[:keep_the_item]
    create!
  end
  
  def follow
    @entry = Entry.find(params[:id])
    current_user.follow(@entry)
    flash[:notice] = "You are now following this item."
    redirect_to :back
  end
  
  def unfollow
    @entry = Entry.find(params[:id])
    current_user.stop_following(@entry)
    flash[:notice] = "You are now stop following this item."
    redirect_to :back
  end

end
