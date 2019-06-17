# frozen_string_literal: true

class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.recent.page(params[:page]).per(20)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to edit_admin_comment_path(@comment)
    else
      render 'edit'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_comments_path, notice: 'Комментарий удалён.'
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :email, :content)
  end
end
