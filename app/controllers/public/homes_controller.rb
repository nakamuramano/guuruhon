class Public::HomesController < ApplicationController
  
# ログインページ、新規登録ページ以外はサインインしていないとアクセスできないが、topページ、ゲストログインはアクセス可能
  
before_action :authenticate_user!, except: [:top, :new_guest]

  def top
    @articles = Article.all.page(params[:page]).per(5)
    @tags = Tag.order(created_at: :desc).limit(6)
  end


end
