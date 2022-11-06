class Admin::UsersController < ApplicationController
  before_action :set_article, only: [:show, :rank, :bookmark, :edit, :update, :withdrawal]
  before_action :check_guest, only: [:update, :destroy, :withdrawal]

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    @articles = @user.articles.page(params[:page]).per(10)
    @comment = Comment.new
  end

  def rank
    @ranks = @user.articles.sort { |a, b| b.comments.count <=> a.comments.count }
  end


  def bookmark
    @tags = Tag.order(created_at: :desc).limit(6)
    @comment = Comment.new
    @bookmarks = @user.bookmarks.page(params[:page]).per(10)
  end

  def edit
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def update
    if @user.update(user_params)
       redirect_to admin_user_path(@user.id)
    else
      @tags = Tag.order(created_at: :desc).limit(6)
      flash[:notice] = '入力し直しててください！'
      render :edit
    end

  end

  def search
    @tags = Tag.order(created_at: :desc).limit(6)
    if params[:content].present?
      @articles = Article.where('content LIKE ?', "%#{params[:content]}%")
      @content = params[:content]
    else
      @articles = Article.all
    end
  end


  def withdrawal
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def set_article
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_active, :profile_image)
  end

  def check_guest
    @user = current_admin
    if @user.email == 'admin@example.com'
      redirect_to admin_user_path, alert: 'ゲストユーザーは編集・削除できません。'
    end
  end

end
