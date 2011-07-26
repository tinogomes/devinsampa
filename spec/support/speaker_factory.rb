require 'action_controller'
# require 'action_controller/test_process.rb'

Factory.define :speaker do |speaker|
  path = "#{Rails.root}/spec/fixtures/rails.png"
  mimetype = "image/png"

  speaker.name { Faker::Name.name }
  speaker.bio { Faker::Lorem.paragraph }
  speaker.email { Faker::Internet.email }
  speaker.avatar { fixture_file_upload(path, mimetype) }
  speaker.twitter { |s| Faker::Internet.user_name(s.name) }
end