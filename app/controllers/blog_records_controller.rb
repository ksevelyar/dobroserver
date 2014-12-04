class BlogRecordsController < ApplicationController
  def show
    @record = @post = @page = BlogRecord.find_by_slug!(params[:id])
    redirect_to root_url unless @record.published? or admin?
  end
end
