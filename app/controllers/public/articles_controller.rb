class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :new_guest]
  before_action :correct_user, only: [:edit]

  def index
    @articles = Article.all.page(params[:page]).per(5)
    @tag_list=Tag.all
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def show
    @user_id = Article.find(params[:id]).user
    @article = Article.find(params[:id])
    @comment = Comment.new
    @article_tags = @article.tags
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
  end

  def new
    @article = Article.new
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_names].split("、")
    if @article.save
     @article.save_tag(tag_list)
      redirect_to articles_path(@article),notice:'投稿完了しました:)'
    else
      render:new
    end
  end

  #def search_tag
   # @tag_list = Tag.all
   # @tag = Tag.find(params[:tag_id])
    #@articles = @tag.articles.all
 # end

  def search
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
    if params[:title].present?
      @articles = Article.where('title LIKE ?', "%#{params[:title]}%").page(params[:page]).per(10)
      @title = params[:title]
    else
      @articles = Article.all.page(params[:page]).per(10)
    end
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list = @article.tags.pluck(:tag_name).join("、")
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
  end

  def update
      @article = Article.find(params[:id])
      tag_list = params[:article][:tag_name].split(",")
    if @article.update(article_params)
       @old_relations = ArticleTag.where(article_id: @article.id)
       @old_relations.each do |relation|
         relation.delete
       end
       @article.save_tag(tag_list)
       redirect_to article_path(@article.id)
    else
       render:edit
    end
  end

  def destroy
    Article.find(params[:id]).destroy()
    redirect_to root_path(params[:article_id])
  end



  private

  def article_params
    params.require(:article).permit(:title, :content, :profile_image)
  end

  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to article_path unless @user == current_user
  end


end