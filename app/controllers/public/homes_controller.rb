class Public::HomesController < ApplicationController

  def top
    @articles = Article.all
    @tags = Tag.order(created_at: :desc).limit(6)
  end


end
