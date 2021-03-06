# frozen_string_literal: true

class Tag < ApplicationRecord
  include Slug

  validates :name, :slug, uniqueness: { case_sensitive: false }, presence: true

  has_and_belongs_to_many :posts, association_foreign_key: :blog_record_id

  scope :published, -> { joins(:posts).where('blog_records.published IS TRUE').distinct }

  scope :cloud, lambda {
    published
      .select('tags.id, tags.name, tags.slug, count(blog_records.id) as posts_count')
      .group('tags.id')
  }

  def count
    posts.published.count
  end

  def self.cloud_sizes
    cloud.map do |tag|
      size = case tag.posts_count
             when 1..3  then 1
             when 4..6  then 2
             when 7..10 then 3
             else 4
             end

      [tag.name, tag.slug, size]
    end
  end

  def self.find_or_create(tag_names, micropost = false)
    tags = tag_names.to_s.split(/,\s*/)
    tags.push 'μ' if tags.empty? || micropost

    tags.uniq.map do |name|
      Tag.find_or_create_by(name: name)
    end
  end
end
