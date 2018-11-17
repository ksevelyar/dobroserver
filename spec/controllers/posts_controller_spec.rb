require 'spec_helper'

describe PostsController, type: :controller do
  describe 'guest access' do
    before :each do
      user = create(:user)
      @post = create(:post, user: user)
    end

    describe 'GET#index' do
      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET#feed' do
      it 'renders the :feed view' do
        get :feed, format: :atom
        expect(response).to render_template :feed
      end
    end

    describe 'GET#show' do
      it 'renders the :show view for published post' do
        get :show, id: @post.slug
        expect(response).to render_template :show
      end

      it 'denies access for non published post' do
        post = create :post, published: false
        get :show, id: post.slug

        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'admin access' do
    before :each do
      @user = create(:user, admin: true)
      session[:user_id] = @user.id

      @post = create(:post, user: @user)
    end

    describe 'GET#show' do
      it 'grants access for non published post' do
        post = create :post, published: false
        get :show, id: post.slug

        expect(response).to render_template :show
      end
    end

    describe 'GET#edit' do
      it 'renders the :edit view' do
        get :edit, id: @post.slug

        expect(response).to render_template :edit
      end
    end

    describe 'GET#new' do
      it 'renders the :edit view' do
        get :new, id: @post.slug

        expect(response).to render_template :new
      end
    end

    describe 'POST#create' do
      it 'saves the valid post to database' do
        expect  do
          post :create, post: attributes_for(:post)
        end.to change(Post, :count).by(1)
      end

      context 'with invalid attributes' do
        it 're-renders new template' do
          post :create, post: attributes_for(:post, raw_content: '')

          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH#update' do
      it 'updates the valid post' do
        patch :update, id: @post.slug,
                       post: attributes_for(:post, raw_content: 'chunky bacon')

        expect(@post.reload.content).to eq 'chunky bacon'
      end

      context 'with invalid attributes' do
        it 're-renders edit template' do
          patch :update, id: @post.slug,
                         post: attributes_for(:post, raw_content: '')

          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes the post' do
        expect do
          delete :destroy, id: @post.slug
        end.to change(Post, :count).by(-1)
      end
    end
  end
end
