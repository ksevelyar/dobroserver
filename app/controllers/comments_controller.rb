class CommentsController < ApplicationController
  skip_before_filter :authorize

  def create
    post = Post.find_by_slug!(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.ip = request.headers["X-Real-IP"]

    if comment.save
      unless comment.email == SETTINGS["mailer"]["to"]
        NotificationsMailer.new_comment(comment).deliver
      end
      # TODO комментарии через ajax или turbolinks
      # respond_to do |format|
      #   format.js
      # end
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if (comment.ip == request.headers["X-Real-IP"] and comment.hot?) or admin?
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :email, :content,
                                    :subject, :nickname)
  end
end
