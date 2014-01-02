class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :posts, dependent: :destroy

  before_save   { self.email.downcase! }

  has_secure_password
end
