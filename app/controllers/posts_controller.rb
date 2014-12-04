class PostsController < BlogRecordsController
  def index
    @posts = Post.published.includes(:comments).page(params[:page]).per(8)
  end

  def feed
    @posts = Post.published.limit(30)

    respond_to do |format|
      format.atom
    end
  end

  def show
    @comment = Comment.new
    super
  end
end
