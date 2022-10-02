class Admin::CommentsController < ApplicationController

  before_action :check_guest, only: [:update, :destroy, :withdrawal]

  def destroy
    Comment.find(params[:id]).destroy()
    redirect_to admin_article_path(params[:article_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def check_guest
    @user = current_admin
    if @user.email == 'admin@example.com'
      redirect_to admin_article_path(params[:article_id]), alert: 'ゲストユーザーは編集・削除できません。'
    end
  end

end
