class ItemsController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
  
  def index
    @items = current_user.items
  end
  
  def show
    @item = Item.includes(:entries).find(params[:id])
    @users = @item.users - [current_user]
  end

  def create
    @item = Item.find_by_url(params[:item][:url]) || Item.create(params[:item])
    UserItem.create(:user => current_user, :item => @item)
    redirect_to @item
  end
  
  def add
    @item = Item.find(params[:id])
    current_user.items << @item
    redirect_to :back
  end
  
  def remove
    @item = Item.find(params[:id])
    current_user.items.delete @item
    redirect_to :back
  end
  
end
