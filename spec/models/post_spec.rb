require 'spec_helper'

describe Post do
  it_behaves_like "BlogRecord"

  it { should validate_presence_of :raw_content }

  it { should have_many(:comments).dependent(:destroy) }
  it { should have_and_belong_to_many(:tags) }

  let(:post) { create :post }

  describe "#tag_names" do
    it "joins tag names to string" do
      post.stub_chain("tags.pluck").with(:name) { ["tag1", "tag2", "tag3"] }
      post.tag_names.should eq "tag1, tag2, tag3"
    end
  end

  describe "#split" do
    it "creates description if #cut" do
      post.content.should eq " content"
      post.description.should eq "description "
    end

    it "does not creates description if #cut non exist" do
      post = create :post, raw_content: "content"
      post.content.should eq "content"
      post.description.should eq nil
    end
  end
end
