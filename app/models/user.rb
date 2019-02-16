class User < ApplicationRecord
  has_secure_password
  has_many :machings
    has_many :works, through: :machings
  attr_accessor :remember_token

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
