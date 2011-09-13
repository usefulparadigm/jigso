class VotesController < ApplicationController
  before_filter :find_voteable
  
  def create
    current_user.send("#{params[:flag]}_vote!".to_sym, @voteable)
    redirect_to :back  
  end
  
  def destroy
    current_user.unvote!(@voteable)
    redirect_to :back  
  end

  private
  
  def find_voteable
    @voteable ||= Entry.find(params[:entry_id])
  end

end
