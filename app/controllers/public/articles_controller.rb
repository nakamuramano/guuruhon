class Public::ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @tag_list=Tag.all
  end

  def show
    @article = Article.find(params[:id])
    @article_comment = ArticleComment.new
    @article_tags = @article.tags
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_names].split(",")
    if @article.save
     @article.save_tag(tag_list)
      redirect_to articles_path(@article),notice:'投稿完了しました:)'
    else
      render:new
    end
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.articles.all
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list = @article.tags.pluck(:tag_name).join(",")
  end

  def update
      @article = Article.find(params[:id])
      tag_list = params[:post][:tag_name].split(",")
    if @article.update(article_params)
      @article.save_tags(tag_list)
      redirect_to article_path(@article.id), notice:'投稿完了しました:)'
    else
      render :edit
    end

  end

  def destroy
    Article.find(params[:id]).destroy()
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

end