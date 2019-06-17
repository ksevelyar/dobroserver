# frozen_string_literal: true

class CommentsController < ApplicationController
  skip_before_action :authorize

  def create
    post = Post.find_by!(slug: params[:post_id])
    comment = post.comments.build(comment_params)
    comment.ip = request.headers['X-Real-IP']

    if comment.save
      redirect_to post_path(post, anchor: 'comments')
    else
      redirect_back(fallback_location: '/')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if editable?

    redirect_back(fallback_location: '/')
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :email, :content,
                                    :subject, :nickname)
  end

  def editable?
    ((@comment.ip == request.headers['X-Real-IP']) && @comment.hot?) || admin?
  end
end
