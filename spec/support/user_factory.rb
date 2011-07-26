Factory.define :user do |f|
  f.name { Faker::Name.name }
  f.username { Faker::Internet.user_name }
  f.email { |u| "#{u.username}@mailinator.com" }
  f.password "test"
  f.password_confirmation {|u| u.password "test"}
end

Factory.define :admin, :parent => :user do |f|
  f.role "admin"
  # f.after_build {|u| u.admin = true }
end