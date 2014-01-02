class Comment < ActiveRecord::Base
  validates :content, :email, :name, :blog_record_id, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }

  # Antispam
  attr_accessor :subject, :nickname
  validates :subject, :nickname, absence: true

  # TODO exclusion registered users nicks

  belongs_to :post, foreign_key: :blog_record_id

  scope :recent, -> { order('created_at DESC') }

  before_save :sanitize_content
  after_create :new_comment_notification

  def hot?
    (Time.zone.now - created_at) <= 30.minutes
  end

  private

  def sanitize_content
    self.content = Sanitize.clean(content,
      elements: ['a', 'div', 'p', 'br', 'code', 'pre', 'ul', 'ol', 'li', 'strong'],
      attributes: {'a' => ['href'], 'div' => ['class']},
      protocols: {'a' => {'href' => ['http', 'https', 'mailto']}})
  end

  def new_comment_notification
    unless email == SETTINGS["mailer"]["to"]
      NotificationsMailer.new_comment(self).deliver
    end
  end
end
