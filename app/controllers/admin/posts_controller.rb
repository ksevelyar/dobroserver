class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(8)
  end

  def new
    @post = current_user.posts.build
    render layout: "editor"
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to edit_post_path(@post.slug)
    else
      render "new"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to edit_post_path(@post.slug)
    else
      render "edit"
    end
  end

  def destroy
    super
    redirect_to posts_path, notice: "Пост удалён."
  end

  private

  def post_params
    params.require(:post).permit(:raw_content, :tag_names, :title, :published, :published_at)
  end
end
