class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :pages, dependent: :destroy

  before_save { self.email.downcase! }


  def to_s
    name
  end
end
