class Admin::BooksController < ApplicationController
  
def index
  @articles = Article.all.page(params[:page]).per(5)
  @tag_list=Tag.all
  @tags = Tag.order(created_at: :desc).limit(6)
  #楽天ブックス検索API 一覧
  if params[:keyword].present?
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
  else
    redirect_to admin_articles_path
  end
end

end
