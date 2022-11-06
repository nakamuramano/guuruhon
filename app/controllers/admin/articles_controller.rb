class Admin::ArticlesController < ApplicationController
  before_action :check_guest, only: [:update, :destroy]
  before_action :set_article, only: [:show, :edit, :update]

  def index
    @articles = Article.all.page(params[:page]).per(5)
    @tag_list=Tag.all
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def show
    @user = Article.find(params[:id]).user
    @comment = Comment.new
    @article_tags = @article.tags
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def edit
    @user = Article.find(params[:id]).user
    @tags = Tag.order(created_at: :desc).limit(6)
    @tag_list = @article.tags.pluck(:tag_name).join("、")
  end

  def update
    tag_list = params[:article][:tag_name].split("、")
    if @article.update(article_params)
       @old_relations = ArticleTag.where(article_id: @article.id)
       @old_relations.each do |relation|
         relation.delete
       end
       @article.save_tag(tag_list)
       redirect_to admin_article_path(@article.id)
    else
       @tags = Tag.order(created_at: :desc).limit(6)
       @user = Article.find(params[:id]).user
       flash[:notice] = '入力し直しててください！'
      render:edit
    end

  end

  def search
     #タグ検索機能
    @tags = Tag.order(created_at: :desc).limit(6)
    if params[:title].present?
      @articles = Article.where('title LIKE ?', "%#{params[:title]}%").page(params[:page]).per(10)
      @title = params[:title]
    else
      @articles = Article.all.page(params[:page]).per(10)
    end
  end

  def destroy
    Article.find(params[:id]).destroy()
    redirect_to admin_articles_path
  end




private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :profile_image)
  end

  def check_guest
    @article = Article.find(params[:id])
    @user = current_admin
    if @user.email == 'admin@example.com'
      redirect_to admin_article_path(@article.id), alert: 'ゲストユーザーは編集・削除できません。'
    end
  end

end
