class Public::HomesController < ApplicationController

  def top
    @articles = Article.all
    @tag_list=Tag.all
    @tags = Tag.all

  end


end
