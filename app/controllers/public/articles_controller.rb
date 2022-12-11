class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :new_guest]
  before_action :correct_user, only: [:edit]
  before_action :set_article, only: [:show, :edit, :update]

  def index
    @articles = Article.all.page(params[:page]).per(5)
    @tag_list=Tag.all
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def show
    @user_id = Article.find(params[:id]).user
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
    #投稿・タグを保存
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @tags = Tag.order(created_at: :desc).limit(6)
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_names].to_s.split("、")
    if @article.save
     @article.save_tag(tag_list)
      redirect_to articles_path(@article),notice:'投稿を完了しました！'
    else
      flash[:notice] = '入力し直しててください！'
      render:new
    end  
  end

  def search
    #キーワード検索機能
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
    @tag_list = @article.tags.pluck(:tag_name).join("、")
    @tags = Tag.order(created_at: :desc).limit(6)
    @user = current_user
  end

  def update
      tag_list = params[:article][:tag_name].split("、")
    if @article.update(article_params)
       @old_relations = ArticleTag.where(article_id: @article.id)
       @old_relations.each do |relation|
         relation.delete
       end
       @article.save_tag(tag_list)
       redirect_to article_path(@article.id)
    else
       @tags = Tag.order(created_at: :desc).limit(6)
       @user = current_user
       flash[:notice] = '入力し直しててください！'
      render:edit
    end
  end

  def destroy
    Article.find(params[:id]).destroy()
    redirect_to root_path(params[:article_id])
  end



  private
  
  def set_article
    @article = Article.find(params[:id])
  end


  def article_params
    params.require(:article).permit(:title, :content, :profile_image, tag: [:tag_name]).merge(user_id: current_user.id)
  end

  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to article_path unless @user == current_user
  end


end