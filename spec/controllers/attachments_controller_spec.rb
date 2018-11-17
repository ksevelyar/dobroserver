require 'spec_helper'

describe AttachmentsController, type: :controller do
  before :each do
    user = create(:user)
    session[:user_id] = user.id

    @page = create(:page, user: user)
  end

  describe 'POST#create' do
    it 'saves the valid attachment' do
      expect  do
        post :create, format: :js,
                      attachment: attributes_for(:attachment), page_id: @page.slug
      end.to change(Attachment, :count).by(1)
    end
  end

  describe 'DELETE#destroy' do
    it 'deletes the attachment' do
      attachment = create(:attachment, blog_record: @page)

      expect do
        delete :destroy, format: :js,
                         page_id: @page.slug, id: attachment.id
      end.to change(Attachment, :count).by(-1)
    end
  end
end
