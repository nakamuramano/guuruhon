class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find(params[:id]).destroy()
    redirect_to root_path(params[:article_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
