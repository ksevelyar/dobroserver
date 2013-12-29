class PagesController < BlogRecordsController
  layout "clean"

  skip_before_filter :authorize, only: :show

  def show
    redirect_to root_url unless @record.published? or admin?

    @meta_title = @record.title
  end

  def new
    @record = Page.new
    render layout: "editor"
  end

  def create
    @record = Page.new(page_params)
    if @record.save
      redirect_to edit_page_path(@record.slug)
    else
      render "new"
    end
  end

  def update
    if @record.update_attributes(page_params)
      redirect_to edit_page_path(@record.slug)
    else
      render "edit"
    end
  end

  def destroy
    super
    redirect_to pages_path, notice: "Страница удалёна."
  end

  private

  def page_params
    params.require(:page).permit(:content, :title, :published, :published_at)
  end
end
