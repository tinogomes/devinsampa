def random_string
  letters = *'a'..'z'
  random_string_for_uniqueness = ''
  10.times { random_string_for_uniqueness += letters[rand(letters.size - 1)]}
  random_string_for_uniqueness
end

Factory.define :user do |f|
  f.name { Faker::Name.name }
  f.username { Faker::Internet.user_name }
  f.email { |u| "#{u.username}@foobar.com" }
  f.password { random_string }
  f.password_confirmation { |u| u.password }
end
