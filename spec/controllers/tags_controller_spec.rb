require 'spec_helper'

describe TagsController do
  render_views

  describe "GET 'show'" do
    it "returns http success" do
      tag = create :tag
      get :show, id: tag.slug

      response.should be_success
      response.should render_template :show
    end
  end
end
