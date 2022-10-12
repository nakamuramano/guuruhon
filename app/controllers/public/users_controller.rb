class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :new_guest]
  before_action :correct_user, only: [:edit, :unsubscribe]


  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page]).per(10)
    @tags = Tag.order(created_at: :desc).limit(6)
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
    @tags = Tag.order(created_at: :desc).limit(6)
  end

  def update
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: 'ゲストユーザーの変更・削除はできません。'
    elsif @user.update(user_params)
       flash[:notice] = "編集しました"
       redirect_to  user_path(@user.id)
    else
       render :edit
    end
  end

  def rank
    @my_ranks = current_user.articles.sort { |a, b| b.comments.count <=> a.comments.count }
    @user = User.find(params[:id])

  end


  def withdrawal
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: 'ゲストユーザーの変更・削除はできません。'
    else
      @user.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end

end
