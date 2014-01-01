class PagesController < BlogRecordsController
  layout "clean"

  skip_before_filter :authorize, only: :show

  def show
    redirect_to root_url unless @page.published? or admin?

    @meta_title = @page.title
  end

  def new
    @page = Page.new
    render layout: "editor"
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to edit_page_path(@page.slug)
    else
      render "new"
    end
  end

  def update
    if @page.update(page_params)
      redirect_to edit_page_path(@page.slug)
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
