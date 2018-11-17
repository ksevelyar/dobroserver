class AttachmentsController < ApplicationController
  def create
    @record = BlogRecord.find_by!(slug: blog_record_params)
    @attachment = @record.attachments.build(attachment_params)

    if @attachment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:attachment)
  end
end
