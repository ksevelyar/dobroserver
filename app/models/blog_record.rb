# frozen_string_literal: true

class BlogRecord < ApplicationRecord
  include Slug

  validates :user_id, :title, :content, :slug, presence: true
  validates :title, :slug, uniqueness: { case_sensitive: false }

  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :attachments, dependent: :destroy

  scope :recent, -> { order('published_at DESC') }
  scope :published, -> { recent.where('published IS TRUE AND published_at <= ?', Time.zone.now) }

  scope :for_sidebar, -> { published.limit(8) }

  after_update :update_files_dir

  def published?
    published && (published_at <= Time.zone.now)
  end

  private

  def update_files_dir
    return unless slug_changed?

    BlogRecordUploader.update_files_dir type, slug_was, slug
  end
end
