namespace :cache do
  desc "Clear cache"
  task :clear do
    `/bin/rm -drf #{File.dirname(__FILE__)}/../../tmp/cache/*`
  end
end