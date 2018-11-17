class TagsController < ApplicationController
  skip_before_action :authorize, only: :show

  def show
    @tag = Tag.find_by!(slug: params[:id])
    @posts = @tag.posts.published.page(params[:page]).per(8)

    @meta_title = @tag.name
  end
end
