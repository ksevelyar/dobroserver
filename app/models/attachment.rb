# frozen_string_literal: true

class Attachment < ApplicationRecord
  validates :attachment, :blog_record_id, presence: true

  belongs_to :blog_record

  mount_uploader :attachment, AttachmentUploader
end
