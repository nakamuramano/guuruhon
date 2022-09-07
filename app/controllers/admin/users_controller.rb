class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = Articles.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end
end
