class Attendee < ActiveRecord::Base
  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX
  validates_presence_of :doc
  
  attr_accessible :name, :email, :doc, :compay
  
  before_create :set_token
  
  private
    def set_token
      self[:token] = Digest::SHA1.hexdigest("#{Time.now}#{email}").slice(0,30).upcase
    end
end
