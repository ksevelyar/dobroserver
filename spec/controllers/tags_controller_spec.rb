# frozen_string_literal: true

require 'spec_helper'

describe TagsController, type: :controller do
  render_views

  describe "GET 'show'" do
    let!(:tag) { create :tag }

    it 'returns http success' do
      get :show, params: { id: tag.slug }

      expect(response).to be_successful
      expect(response).to render_template :show
    end
  end
end
