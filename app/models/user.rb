class User < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  #VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/
  validates :password, presence: true#, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true

  has_many :posts, dependent: :destroy

  before_save   { self.email.downcase! }
  before_create { generate_token(:remember_token) }

  has_secure_password

  private

  def generate_token column
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
