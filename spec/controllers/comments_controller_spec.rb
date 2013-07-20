require 'spec_helper'

describe CommentsController do
  before :each do
    user = create(:user)
    @post = create(:post, user: user)

    request.env["HTTP_REFERER"] = ""
    request.headers["X-Real-IP"] = "42.42.42.42"
  end

  describe "POST#create" do
    it "saves the valid comment" do
      expect{
        post :create,
             comment: attributes_for(:comment), post_id: @post.slug
      }.to change(Comment, :count).by(1)
    end

    context "with invalid attributes" do
      it "re-renders new template" do
        expect{
          post :create,
               comment: attributes_for(:comment, email: "invalid_email"),
               post_id: @post.slug

        }.to change(Comment, :count).by(0)
      end
    end
  end

  describe "DELETE#destroy" do
    it "deletes the comment" do
      comment = create(:comment, post: @post, ip: "42.42.42.42")

      expect{
        delete :destroy, post_id: @post.slug, id: comment.id
      }.to change(Comment, :count).by(-1)
    end
  end
end
