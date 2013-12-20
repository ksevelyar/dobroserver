class AdminController < ApplicationController
  def index
    @posts = Post.recent.page(params[:page]).per(50)
  end
end
