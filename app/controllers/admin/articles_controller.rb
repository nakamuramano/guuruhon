class Admin::ArticlesController < ApplicationController
    def index
        @articles = Article.all
        @tag_list=Tag.all
    end

    def show
        @article = Article.find(params[:id])
        @user = Article.find(params[:id]).user
        @comment = Comment.new
        @article_tags = @article.tags
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
          if @article.update(article_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to admin_article_path(@article.id)
          else
            render :edit
          end
    end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @articles = @tag.articles.all
  end

  def search
    if params[:content].present?
      @articles = Article.where('content LIKE ?', "%#{params[:content]}%")
      @content = params[:content]
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
