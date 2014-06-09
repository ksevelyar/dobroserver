require 'spec_helper'

describe Tag, :type => :model do
  describe "#count" do
    it "returns published posts count for tag" do
      create :post, published: false, tag_names: "test"
      create :post, title: "post_2",  tag_names: "test"
      create :post, title: "post_3",  tag_names: "test"

      expect(Tag.last.count).to eq 2
    end
  end

  describe ".cloud" do
    it "returns tag cloud" do
      tag1 = double(name: "Tag1", slug: "tag1", count: 1)
      tag2 = double(name: "Tag2", slug: "tag2", count: 4)
      tag3 = double(name: "Tag3", slug: "tag3", count: 2)
      tag4 = double(name: "Tag4", slug: "tag4", count: 10)
      tag5 = double(name: "Tag5", slug: "tag5", count: 15)

      expect(described_class).to receive(:published).and_return([tag1, tag2, tag3, tag4, tag5])

      expect(described_class.cloud).to eq [["Tag1", "tag1", 1],
                                       ["Tag2", "tag2", 2],
                                       ["Tag3", "tag3", 1],
                                       ["Tag4", "tag4", 3],
                                       ["Tag5", "tag5", 4]]
    end
  end
end
