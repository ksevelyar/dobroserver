# frozen_string_literal: true

require 'spec_helper'

describe PagesController, type: :controller do
  describe 'guest access' do
    before :each do
      user = create(:user)
      @page = create(:page, user: user)
    end

    describe 'GET#show' do
      it 'renders the :show view for published page' do
        get :show, params: { id: @page.slug }
        expect(response).to render_template :show
      end

      it 'denies access for non published page' do
        page = create :page, published: false
        get :show, params: { id: page.slug }

        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'admin access' do
    before :each do
      @user = create(:user, admin: true)
      session[:user_id] = @user.id

      @page = create(:page, user: @user)
    end

    describe 'GET#show' do
      it 'grants access for non published page' do
        page = create :page, published: false
        get :show, params: { id: page.slug }

        expect(response).to render_template :show
      end
    end

    describe 'GET#edit' do
      it 'renders the :edit view' do
        get :edit, params: { id: @page.slug }

        expect(response).to render_template :edit
      end
    end

    describe 'GET#new' do
      it 'renders the :edit view' do
        get :new, params: { id: @page.slug }

        expect(response).to render_template :new
      end
    end

    describe 'POST#create' do
      it 'saves the valid page to database' do
        expect  do
          post :create, params: { page: attributes_for(:page) }
        end.to change(Page, :count).by(1)
      end

      context 'with invalid attributes' do
        it 're-renders new template' do
          post :create, params: { page: attributes_for(:page, content: '') }

          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH#update' do
      it 'updates the valid page' do
        patch :update, params: { id: @page.slug, page: attributes_for(:page, content: 'chunky bacon') }

        expect(@page.reload.content).to eq 'chunky bacon'
      end

      context 'with invalid attributes' do
        it 're-renders edit template' do
          patch :update, params: { id: @page.slug, page: attributes_for(:page, content: '') }

          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes the page' do
        expect do
          delete :destroy, params: { id: @page.slug }
        end.to change(Page, :count).by(-1)
      end
    end
  end
end
