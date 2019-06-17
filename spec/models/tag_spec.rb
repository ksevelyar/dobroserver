# frozen_string_literal: true

require 'spec_helper'

describe Tag, type: :model do
  describe '#count' do
    it 'returns published posts count for tag' do
      create :post, published: false, tag_names: 'test'
      create :post, title: 'post_2',  tag_names: 'test'
      create :post, title: 'post_3',  tag_names: 'test'

      expect(Tag.last.count).to eq 2
    end
  end

  describe '.cloud_sizes' do
    let(:tags_array) do
      [
        double(name: 'Tag1', slug: 'tag1', posts_count: 1),
        double(name: 'Tag2', slug: 'tag2', posts_count: 4),
        double(name: 'Tag3', slug: 'tag3', posts_count: 2),
        double(name: 'Tag4', slug: 'tag4', posts_count: 10),
        double(name: 'Tag5', slug: 'tag5', posts_count: 15)
      ]
    end

    it 'returns tag cloud' do
      expect(described_class).to receive(:cloud).and_return(tags_array)

      expect(described_class.cloud_sizes).to eq [['Tag1', 'tag1', 1],
                                                 ['Tag2', 'tag2', 2],
                                                 ['Tag3', 'tag3', 1],
                                                 ['Tag4', 'tag4', 3],
                                                 ['Tag5', 'tag5', 4]]
    end
  end
end
