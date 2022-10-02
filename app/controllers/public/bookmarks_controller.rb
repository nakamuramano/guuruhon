class Public::BookmarksController < ApplicationController

before_action :authenticate_user!, except: [:top, :new_guest]

  def index
    @user = current_user
    @bookmarks = Bookmark.where(user_id: @user.id).page(params[:page]).per(10)
    @tags = Tag.order(created_at: :desc).limit(6)
  end
  
  def create
    @article = Article.find(params[:article_id])
    bookmark = @article.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end

  end

  def destroy
    @article = Article.find(params[:article_id])
    bookmark = @article.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end

  end



end
