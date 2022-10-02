class Admin::TagsController < ApplicationController

  before_action :check_guest, only: [:destroy]

  def index
    @tags = Tag.all.page(params[:page]).per(20)
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.all.page(params[:page]).per(5)
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to admin_tags_path
  end


  def check_guest
    @user = current_admin
    if @user.email == 'admin@example.com'
      redirect_to admin_tags_path, alert: 'ゲストユーザーは編集・削除できません。'
    end
  end

end
