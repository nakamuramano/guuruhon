class Admin::BookmarksController < ApplicationController

  def index
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id)
    
  end

  def create
    @article = Article.find(params[:article_id])
    bookmark = @article.bookmarks.new(user_id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end

  end

  def destroy
    @article = Article.find(params[:article_id])
    bookmark = @article.bookmarks.find_by(user_id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end

  end


end
