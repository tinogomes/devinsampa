# encoding: utf-8
class User < ActiveRecord::Base
  EMAIL_REGEX = %r"(?:[a-z0-9!#$\%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$\%&'*+/=?^_`{|}~-]+)*|\"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"

  attr_accessible :name, :username, :email, :password, :password_confirmation

  attr_accessor :password

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, :format => {:with => EMAIL_REGEX}
  validates :password, :presence => true, :confirmation => true, :if => :new_record?

  before_validation :downcase_username
  before_save :encrypt_password

  def self.authenticate(username, password)
    user = find_by_username(username) || find_by_email(username)
    user && user.password_hash == User.hash_secret(password, user.password_salt) ? user : nil
  end

  def self.hash_secret(password, password_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def admin?
    role == "admin"
  end

  protected
  def downcase_username
    self.username.try(:downcase!)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = User.hash_secret(password, self.password_salt)
    end
  end

end
