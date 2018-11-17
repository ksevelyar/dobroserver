class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: Продумать авторизацию
  before_action :authorize, :sidebar

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    redirect_to root_url unless current_user
  end

  def admin?
    current_user.try(:admin?)
  end

  # OPTIMIZE: вытащить в blog_records_controller?
  def blog_record_params
    params[:post_id] || params[:page_id]
  end

  def sidebar
    @tags_cloud = Tag.cloud_sizes
    @posts_sidebar = Post.for_sidebar
    @comments_sidebar = Comment.for_sidebar
  end
end
