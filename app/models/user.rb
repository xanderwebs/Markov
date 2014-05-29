class User < ActiveRecord::Base
  attr_reader :password
  before_save :encrypt_password

  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      @password = unencrypted_password
    end
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end
end
