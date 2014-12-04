class BlogRecord < ActiveRecord::Base
  include Slug

  validates :user_id, :title, :content, :slug, presence: true
  validates :title, :slug, uniqueness: { case_sensitive: false }

  belongs_to :admin_user
  has_many :images, dependent: :destroy
  has_many :attachments, dependent: :destroy

  scope :recent, -> { order('published_at DESC') }
  scope :published, -> { recent.where('published IS TRUE AND published_at <= ?', Time.zone.now) }
  scope :draft, -> { where('published IS FALSE') }

  def published?
    published == true and published_at <= Time.zone.now
  end

  after_update  :update_files_dir
  after_destroy :remove_files_dir

  private

  def update_files_dir
    if slug_changed?
      BlogRecordUploader.update_files_dir type, slug_was, slug
    end
  end

  def remove_files_dir
    BlogRecordUploader.remove_files_dir type, slug
  end
end
