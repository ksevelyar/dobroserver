class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    redirect_to root_url if session[:remember_token].present?
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user and user.authenticate(params[:session][:password])
      reset_session
      session[:remember_token] = user.remember_token
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
