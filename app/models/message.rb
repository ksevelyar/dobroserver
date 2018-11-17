class Message
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :content

  # TODO: antispam
  validates :name, :email, :subject, :content, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
