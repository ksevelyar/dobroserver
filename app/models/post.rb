class Post < BlogRecord
  attr_writer :raw_content, :tag_names

  has_many :comments, foreign_key: :blog_record_id, dependent: :destroy
  has_and_belongs_to_many :tags, -> { order(slug: :asc) }, foreign_key: :blog_record_id
  before_validation :split
  after_save :assign_tags

  def raw_content
    if description
      @raw_content || "#{description}#cut#{content}"
    else
      @raw_content || content.to_s
    end
  end

  def tag_names
    @tag_names || tags.pluck(:name).join(', ')
  end

  private

  def split
    if raw_content.include? "#cut"
      self.description = raw_content.split("#cut").first
      self.content     = raw_content.split("#cut").last
    else
      self.description = nil
      self.content     = raw_content
    end
  end

  def assign_tags
    self.tags = Tag.find_or_create(@tag_names)
  end
end
