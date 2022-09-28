class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @tag_list=Tag.all
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def show
    @article = Article.find(params[:id])
    @user = Article.find(params[:id]).user
    @comment = Comment.new
    @article_tags = @article.tags
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def edit
    @article = Article.find(params[:id])
    @user = Article.find(params[:id]).user
    @tags = Tag.order(created_at: :desc).limit(6)
    @tag_list = @article.tags.pluck(:tag_name).join("、")

  end

  def update
      @article = Article.find(params[:id])
      tag_list = params[:article][:tag_name].split("、")
    if @article.update(article_params)
       @old_relations = ArticleTag.where(article_id: @article.id)
       @old_relations.each do |relation|
         relation.delete
       end
       @article.save_tag(tag_list)
       redirect_to admin_article_path(@article.id)
    else
       render:edit
    end
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @articles = @tag.articles.all
  end

  def search
    @tags = Tag.order(created_at: :desc).limit(6)
    if params[:title].present?
      @articles = Article.where('title LIKE ?', "%#{params[:title]}%")
      @title = params[:title]
    else
      @articles = Article.all
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
end
