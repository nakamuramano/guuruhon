class Admin::TagsController < ApplicationController
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


end
