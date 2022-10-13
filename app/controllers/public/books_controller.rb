class Public::BooksController < ApplicationController

def index
    @articles = Article.all.page(params[:page]).per(5)
    @tag_list=Tag.all
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
    #楽天API 検索一覧
  if params[:keyword].present?
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
  else
    redirect_to articles_path
  end
end

end
