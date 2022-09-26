class Public::TagsController < ApplicationController

  def index
    @tags = Tag.all
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.all
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end



  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end



end
