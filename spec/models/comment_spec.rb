require 'spec_helper'

describe Comment do
  it { should validate_presence_of :content }
  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :blog_record_id }

  # Antispam
  # it { should validate_absence_of :subject }
  # it { should validate_absence_of :nickname }

  it { should allow_value('ksevelyar@domain.com').for(:email) }
  it { should_not allow_value('ksevelyar@domain').for(:email) }

  it { should belong_to :post }

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
    pending
  end
end
