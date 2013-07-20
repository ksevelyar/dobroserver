require 'spec_helper'

describe Comment do
  describe "#hot" do
    it "returns true for new comments" do
      post = create :post
      comment = create :comment, post: post

      comment.hot?.should be_true
    end

    it "returns false for old comments" do
      post = create :post
      comment = create :comment, post: post, created_at: Time.now - 40.minutes

      comment.hot?.should be_false
    end
  end

  describe "sanitize" do

  end
end
