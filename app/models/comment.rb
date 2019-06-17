# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, :email, :name, :blog_record_id, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }

  # Antispam
  attr_accessor :subject, :nickname
  validates :subject, :nickname, absence: true

  # TODO: exclusion registered users nicks

  belongs_to :post, foreign_key: :blog_record_id

  scope :recent, -> { order('created_at DESC') }

  scope :for_sidebar, -> { recent.includes(:post).limit(8) }

  before_save :sanitize_content
  after_create :new_comment_notification

  def hot?
    30.minutes.ago <= created_at
  end

  private

  def sanitize_content
    self.content = Sanitize.clean(content,
                                  elements: %w[a div p br code pre ul ol li strong],
                                  attributes: { 'a' => ['href'], 'div' => ['class'] },
                                  protocols: { 'a' => { 'href' => %w[http https mailto] } })
  end

  def new_comment_notification
    NotificationsMailer.new_comment(self).deliver_now unless email == Settings.mailer.to
  end
end
