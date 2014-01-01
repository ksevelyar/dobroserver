class PostsController < BlogRecordsController
  skip_before_filter :authorize, only: [:index, :feed, :show]

  def index
    @posts = Post.published.page(params[:page]).per(8)
  end

  def feed
    @posts = Post.published.limit(50)

    respond_to do |format|
      format.atom
    end
  end

  def show
    @comment = Comment.new
    @meta_title = @post.title
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
