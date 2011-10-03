class UserItemsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @item = Item.find(params[:item_id])
    current_user.items << @item
    redirect_to :back
  end
  
  def destroy
    @item = Item.find(params[:id])
    current_user.items.delete @item
    redirect_to :back
  end
  
end
