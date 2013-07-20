class TagsController < ApplicationController
  skip_before_filter :authorize, only: :show

  def show
    @tag = Tag.find_by_slug!(params[:id])
    @posts = @tag.posts.published.page(params[:page]).per(8)

    @meta_title = @tag.name
  end
end
