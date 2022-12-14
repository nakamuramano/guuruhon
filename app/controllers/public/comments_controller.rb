class Public::CommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = current_user.comments.new(comment_params)
    comment.article_id = article.id
    if comment.save
      redirect_to article_path(article)
    else
      redirect_to article_path(article)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy()
    redirect_to root_path(params[:article_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
