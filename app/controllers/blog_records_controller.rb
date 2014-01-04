class BlogRecordsController < ApplicationController
  before_action :find_record, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: :show

  def edit
    @attachment = Attachment.new
    @image = Image.new

    render layout: "editor"
  end

  def destroy
    @record.destroy
  end

  protected

  def find_record
    @record = @post = @page = BlogRecord.find_by_slug!(params[:id])
  end

  def check_access
    redirect_to root_url unless @record.published? or admin?
  end
end
