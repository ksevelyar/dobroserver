class PagesController < BlogRecordsController
  layout "clean"

  def show
    super
    redirect_to root_url unless @page.published? or admin?
  end
end
