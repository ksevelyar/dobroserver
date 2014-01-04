class CommentsController < ApplicationController
  skip_before_action :authorize

  def create
    post = Post.find_by_slug!(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.ip = request.headers["X-Real-IP"]

    if comment.save
      # TODO комментарии через ajax или turbolinks
      # respond_to do |format|
      #   format.js
      # end
      redirect_to post_path(post, anchor: "comments")
    else
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if editable?
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :email, :content,
                                    :subject, :nickname)
  end

  # TODO подключить в интерфейсе
  def editable?
    (@comment.ip == request.headers["X-Real-IP"] and @comment.hot?) or admin?
  end
end
