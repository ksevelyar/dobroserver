require 'spec_helper'

describe TagsController, :type => :controller do
  render_views

  describe "GET 'show'" do
    it "returns http success" do
      tag = create :tag
      get :show, id: tag.slug

      expect(response).to be_success
      expect(response).to render_template :show
    end
  end
end
