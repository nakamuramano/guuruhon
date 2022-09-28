class Public::HomesController < ApplicationController
before_action :authenticate_user!, except: [:top, :new_guest]

  def top
    @articles = Article.all
    @tags = Tag.order(created_at: :desc).limit(6)
  end


end
