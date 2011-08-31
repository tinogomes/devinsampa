set :application, "devinsampa"
set :user, "devinsampa"

set :deploy_to, "/home/devinsampa/rails"

set :scm, 'git'
set :repository, "git://github.com/tinogomes/devinsampa.git"
set :deploy_via, :remote_cache
set :branch, 'versao-2011'
set :scm_verbose, true

set :use_sudo, false

server "devinsampa", :app, :web, :db, :primary => true

after "deploy:update_code", "deploy:copy_config_files"
before "deploy:symlink", "deploy:create_speaker_images_symlink"
before "deploy:symlink", "deploy:create_public_files_symlink"
after "deploy:update", "deploy:cleanup"

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
    end

  desc "[internal] Copy config files to current_release"
  task :copy_config_files do
    run "cp #{shared_path}/config/*.yml #{release_path}/config/"
  end

  desc "[internal] Create symlink to speaker images"
  task :create_speaker_images_symlink do
    run "cd #{release_path}/public/images && /bin/ln -s #{shared_path}/speakers"
  end

  desc "[internal] Create symlink to public files"
  task :create_public_files_symlink do
    run "cd #{release_path}/public && /bin/ln -s #{shared_path}/public/googlehostedservice.html"
  end
end

