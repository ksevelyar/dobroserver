require 'spec_helper'

describe AttachmentsController do
  before :each do
    user = create(:user)
    session[:user_id] = user.id

    @page = create(:page, user: user)
  end

  describe "POST#create" do
    it "saves the valid attachment" do
      expect{
        post :create, format: :js,
        attachment: attributes_for(:attachment), page_id: @page.slug
      }.to change(Attachment, :count).by(1)
    end
  end

  describe "DELETE#destroy" do
    it "deletes the attachment" do
      attachment = create(:attachment, blog_record: @page)

      expect{
        delete :destroy, format: :js,
        page_id: @page.slug, id: attachment.id
      }.to change(Attachment, :count).by(-1)
    end
  end
end
