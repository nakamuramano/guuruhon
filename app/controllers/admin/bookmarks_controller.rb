class Admin::BookmarksController < ApplicationController

  def index
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id).page(params[:page]).per(10)
    
  end

end
