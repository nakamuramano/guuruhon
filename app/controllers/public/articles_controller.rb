class Public::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      @article.save_tags(params[:article][:tag])
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      @article.save_tags(params[:article][:tag])
      redirect_to article_path(@article)
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
