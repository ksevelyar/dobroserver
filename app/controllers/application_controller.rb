class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # OPTIMIZE вытащить в blog_records_controller?
  def blog_record_params
    params[:post_id] || params[:page_id]
  end
end
