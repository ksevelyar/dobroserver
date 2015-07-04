class Tag < ActiveRecord::Base
  include Slug

  validates :name, :slug, uniqueness: { case_sensitive: false }, presence: true

  has_and_belongs_to_many :posts, association_foreign_key: :blog_record_id

  scope :published, -> { joins(:posts).where('published IS TRUE').uniq }

  def count
    posts.published.count
  end

  # OPTIMIZE THIS SHITTY SHIT
  def self.cloud
    published.map do |tag|
      size = case tag.count
             when 1..3  then 1
             when 4..6  then 2
             when 7..10 then 3
             else 4
             end

      [tag.name, tag.slug, size]
    end
  end

  # FIXME игнорировать не уникальные slug
  def self.find_or_create tag_names, micropost=false
    tags = tag_names.to_s.split(/,\s*/)
    tags.push "μ" if tags.empty? or micropost

    tags.uniq.map do |name|
      Tag.find_or_create_by(name: name)
    end
  end
end
