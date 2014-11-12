require 'spec_helper'

describe Post, type: :model do
  it_behaves_like "BlogRecord"

  it { is_expected.to validate_presence_of :raw_content }

  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:tags) }

  let(:post) { create :post }

  describe "#tag_names" do
    it "joins tag names to string" do
      allow(post).to receive_message_chain("tags.pluck").with(:name) { ["tag1", "tag2", "tag3"] }
      expect(post.tag_names).to eq "tag1, tag2, tag3"
    end
  end

  describe "#split" do
    it "creates description if #cut" do
      expect(post.content).to eq " content"
      expect(post.description).to eq "description "
    end

    it "does not creates description if #cut non exist" do
      post = create :post, raw_content: "content"
      expect(post.content).to eq "content"
      expect(post.description).to eq nil
    end
  end
end
