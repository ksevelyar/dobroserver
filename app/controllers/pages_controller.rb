class PagesController < ApplicationController
  layout "clean"

  skip_before_filter :authorize, only: :show

  def show
    @page = Page.find_by_slug!(params[:id])
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

  def edit
    @page = @record = BlogRecord.find_by_slug!(params[:id])

    @attachment = Attachment.new
    @image = Image.new

    @meta_title = @page.title

    render layout: "editor"
  end

  def update
    @page = Page.find_by_slug!(params[:id])

    if @page.update_attributes(page_params)
      redirect_to edit_page_path(@page.slug)
    else
      render "edit"
    end
  end

  def destroy
    Page.find_by_slug!(params[:id]).destroy
    redirect_to pages_path, notice: "Страница удалёна."
  end

  private

  def page_params
    params.require(:page).permit(:content, :title, :published, :published_at)
  end
end
