class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles

    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: 'ゲストユーザーの変更・削除はできません。'
    elsif @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to  user_path(@user.id)
    else
       render :edit
    end
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

end
