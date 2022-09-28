class Admin::BookmarksController < ApplicationController

  def index
    @tags = Tag.order(created_at: :desc).limit(6)
    @bookmarks = @user.bookmarks
    @tags = Tag.order(created_at: :desc).limit(6)
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
