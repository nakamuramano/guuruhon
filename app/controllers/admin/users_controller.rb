class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @comment = Comment.new
    @bookmarks = @user.bookmarks
  end

  def edit
    @user = User.find(params[:id])
    @user = Article.find(params[:id]).user
    @tags = Tag.order(created_at: :desc).limit(6)
    @bookmarks = @user.bookmarks
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_articles_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_active, :profile_image)
  end
end
