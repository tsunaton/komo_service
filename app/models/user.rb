class User < ApplicationRecord
has_many :available_halls
has_many :funeral_halls, through: :available_halls
has_many :matcings
has_many :funerals, through: :matcings
has_many :shifts
has_many :working_hours

validates :name, presence: true, length: { maximum: 50 }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
with_options length: { maximum: 50 } do
  validates :address
  validates :nearest_station
end


validates :pay_per_hour, numericality: { less_than: 10000 }

  attr_accessor :remember_token
  has_secure_password

  # ただランダムなトークンを返すだけ
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # ハッシュ作る
   def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  #ユーザを永続sessionの対象として保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
