class Speaker < ActiveRecord::Base
  has_attachment :storage => :file_system,
                 :content_type  => :image,
                 :size => 1..300.kilobytes,
                 :path_prefix => "public/images/speakers"
                 
  # validates_as_attachment
  
  validates_presence_of :name
  validates_presence_of :bio
  validates_presence_of :presentation
  validates_presence_of :description
  validates_presence_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX, :if => proc { |obj| !obj.email.blank? }
end
