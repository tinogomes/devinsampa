require 'action_controller'
require 'action_controller/test_process.rb'

Factory.define :speaker do |speaker|
  path = "#{Rails.root}/spec/fixtures/rails.png"
  mimetype = "image/png"
  
  speaker.name { Faker::Name.name }
  speaker.bio { Faker::Lorem.paragraph }
  speaker.presentation { Faker::Lorem.sentence }
  speaker.description { Faker::Lorem.paragraph }
  speaker.email { Faker::Internet.email }
  speaker.uploaded_data { ActionController::TestUploadedFile.new(path, mimetype) }
end