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
    @meta_title = @record.title
  end

  def new
    @record = current_user.posts.build
    render layout: "editor"
  end

  def create
    @record = current_user.posts.build(post_params)
    if @record.save
      redirect_to edit_post_path(@record.slug)
    else
      render "new"
    end
  end

  def update
    if @record.update_attributes(post_params)
      redirect_to edit_post_path(@record.slug)
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
