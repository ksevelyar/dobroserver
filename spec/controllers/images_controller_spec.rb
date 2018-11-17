require 'spec_helper'

describe ImagesController, type: :controller do
  before :each do
    user = create(:user)
    session[:user_id] = user.id

    @page = create(:page, user: user)
  end

  describe 'POST#create' do
    it 'saves the valid image' do
      expect  do
        post :create, format: :js,
                      image: attributes_for(:image), page_id: @page.slug
      end.to change(Image, :count).by(1)
    end
  end

  describe 'DELETE#destroy' do
    it 'deletes the image' do
      image = create(:image, blog_record: @page)

      expect  do
        delete :destroy, format: :js,
                         page_id: @page.slug, id: image.id
      end.to change(Image, :count).by(-1)
    end
  end
end
