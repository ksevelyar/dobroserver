class ImagesController < ApplicationController
  def create
    @record = BlogRecord.find_by!(slug: blog_record_params)
    @image = @record.images.build(image_params)

    if @image.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end
end
