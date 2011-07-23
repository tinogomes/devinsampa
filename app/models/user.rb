# encoding: utf-8
class User < ActiveRecord::Base
  EMAIL_REGEX = %r"(?:[a-z0-9!#$\%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$\%&'*+/=?^_`{|}~-]+)*|\"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
  acts_as_authentic

  validates_presence_of :name
  validates_presence_of :username
  validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :password

  attr_accessible :name, :username, :email, :password, :password_confirmation

  #TODO: kill this power feature
  def give_power
    self.role = "admin"
    self.save
  end

  #TODO: kill this power feature
  def self.name_username_email_password_admin(name, username, email, password)
    admin = User.create :name => name,
                        :username => username,
                        :email => email,
                        :password => password,
                        :password_confirmation => password
    admin.give_power
  end
end
